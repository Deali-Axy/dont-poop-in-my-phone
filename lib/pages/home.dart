import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/common/update.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/services/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _future;
  var _currentPath = StarFileSystem.SDCARD_ROOT;
  bool _isRootPath = true;
  DateTime _lastWillPopAt; //上次返回退出动作时间
  final _currentDirs = <String>[];
  final _currentFiles = <String>[];

  @override
  void initState() {
    super.initState();

    // 显示状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    var systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    requestPermission();
    AppUpdate.checkUpdate(context);
  }

  /// 请求权限
  requestPermission() async {
    if (Platform.isAndroid) {
      var permissions = <Permission>[];
      var deviceInfo = DeviceInfoPlugin();
      var androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt > 29) {
        permissions.add(Permission.manageExternalStorage);
      } else {
        permissions.add(Permission.storage);
      }

      var statuses = await permissions.request();
      for (var item in statuses.entries) {
        if (item.value.isDenied) {
          BotToast.showText(text: '需要存储权限才能扫描流氓App在手机里拉的屎~');
        }

        if (item.value.isPermanentlyDenied) {
          BotToast.showText(text: '永久拒绝权限需要到设置中手动开启！');
          openAppSettings();
          return;
        }
      }

      setState(() {
        _future = StarFileSystem.listSdCard();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('别在我的手机里拉屎！'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _turnToPath(_currentPath),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<FileSystemEntity>>(
        future: _future,
        builder: (ctx, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _buildNoPermissionBody();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()));
            case ConnectionState.done:
              if (snapshot.hasError) {
                return _buildErrorBody(snapshot.error);
              } else {
                _currentFiles.clear();
                _currentDirs.clear();
                for (var entity in snapshot.data) {
                  if (FileSystemEntity.isFileSync(entity.path)) {
                    _currentFiles.add(entity.path);
                  } else {
                    _currentDirs.add(entity.path);
                  }
                  // 根据名称排序
                  _currentDirs.sort((a, b) => path.basename(a).compareTo(path.basename(b)));
                  _currentFiles.sort((a, b) => path.basename(a).compareTo(path.basename(b)));
                }
              }
              return snapshot.hasError ? _buildErrorBody(snapshot.error) : _buildBody();
          }
          return null;
        },
      ),
    );

    return WillPopScope(
      child: scaffold,
      onWillPop: () async {
        if (_lastWillPopAt == null || DateTime.now().difference(_lastWillPopAt) > Duration(seconds: 1)) {
          BotToast.showText(text: '再按一次返回键退出应用~');
          //两次点击间隔超过1秒则重新计时
          _lastWillPopAt = DateTime.now();
          return false;
        }
        return true;
      },
    );
  }

  Widget _buildNoPermissionBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_outlined, size: 120),
          SizedBox(height: 15),
          Text('无法访问手机存储，请先授权', style: TextStyle(fontSize: 20)),
          SizedBox(height: 15),
          OutlinedButton(child: Text('打开设置'), onPressed: () => openAppSettings()),
        ],
      ),
    );
  }

  Widget _buildErrorBody(Object error) {
    String friendlyText;
    if (error is FileSystemException) {
      friendlyText = '无权访问该目录';
    } else {
      friendlyText = '未知错误';
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_outlined, size: 120),
          SizedBox(height: 15),
          Text(friendlyText, style: TextStyle(fontSize: 20)),
          SizedBox(height: 15),
          OutlinedButton(child: Text('返回上级目录'), onPressed: _backToParentPath),
        ],
      ),
    );
  }

  Widget _buildBody() {
    var listviewChildren = <Widget>[];

    if (!_isRootPath) {
      listviewChildren.add(GestureDetector(
        child: Card(
          child: ListTile(
            leading: Icon(Icons.keyboard_return),
            title: Text('返回上级目录'),
          ),
        ),
        onTap: _backToParentPath,
      ));
    }

    for (var item in _currentDirs) {
      listviewChildren.add(_buildDirectory(item));
    }
    for (var item in _currentFiles) {
      listviewChildren.add(_buildFile(item));
    }

    return ListView(children: listviewChildren);
  }

  Widget _buildFile(String entityPath) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.description_outlined, size: 40),
        title: Text(path.basename(entityPath)),
        subtitle: Text(StarFileSystem.getFileSize(entityPath)),
      ),
    );
  }

  Widget _buildDirectory(String entityPath) {
    var dirName = path.basename(entityPath);

    var menuButton = PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case 1:
            await _procDirAction(entityPath, ActionType.deleteAndReplace);
            break;
          case 2:
            await _procDirAction(entityPath, ActionType.delete);
            break;
        }

        // 删除后不需要刷新，这样页面不会闪烁
        // 刷新列表
        // _turnToPath(_currentPath);
      },
      itemBuilder: (context) => <PopupMenuItem<int>>[
        PopupMenuItem(value: 1, child: StarTextButton(icon: const Icon(Icons.do_not_disturb), text: '删除并替换')),
        PopupMenuItem(value: 2, child: StarTextButton(icon: const Icon(Icons.delete_outline), text: '仅删除')),
      ],
    );

    var card = Card(
      child: ListTile(
        leading: Icon(Icons.folder, size: 40),
        title: Text(dirName),
        subtitle: StarFileSystem.isInWhiteList(entityPath) && _isRootPath ? Text('重要文件，不支持清理') : Text(entityPath),
        trailing: StarFileSystem.isInWhiteList(entityPath) && _isRootPath ? null : menuButton,
      ),
    );

    return GestureDetector(child: card, onTap: () => _turnToPath(entityPath));
  }

  /// 处理文件夹操作
  Future _procDirAction(String entityPath, ActionType actionType) async {
    var dirName = path.basename(entityPath);

    String title = '';
    switch (actionType) {
      case ActionType.delete:
        title = '删除目录';
        break;
      case ActionType.deleteAndReplace:
        title = '删除并替换目录';
        break;
      default:
        return;
    }
    var result = await showDeleteDirDialog(context, title: title);
    if (!result) return;

    showLoading(context);
    try {
      await StarFileSystem.deleteDirectory(entityPath);
      if (actionType == ActionType.deleteAndReplace) {
        StarFileSystem.createFile(dirName);
      }
      var history = new History(
        name: dirName,
        path: entityPath,
        time: DateTime.now(),
        actionType: actionType,
      );

      BotToast.showText(text: '处理文件夹 $dirName 完成！');

      setState(() {
        _currentDirs.remove(entityPath);
        // 替换的话，把目录加到文件那里去
        if (actionType == ActionType.deleteAndReplace) {
          _currentFiles.add(entityPath);
        }
      });

      Global.appConfig.history.add(history);
      Global.saveAppConfig();
    } catch (ex) {
      BotToast.showText(text: '处理文件夹失败！$ex');
    } finally {
      Navigator.of(context).pop();
    }
  }

  void _backToParentPath() {
    setState(() {
      var parentPath = path.dirname(_currentPath);
      _future = StarFileSystem.listDir(parentPath);
      _currentPath = parentPath;
      if (parentPath == StarFileSystem.SDCARD_ROOT) {
        _isRootPath = true;
      }
    });
  }

  void _turnToPath(String path) {
    setState(() {
      _currentPath = path;
      _isRootPath = path == StarFileSystem.SDCARD_ROOT;
      try {
        _future = StarFileSystem.listDir(path);
      } catch (ex) {
        if (ex is FileSystemException) {
          BotToast.showText(text: '无权访问该目录！');
        } else {
          BotToast.showText(text: '未知错误～');
        }
        _backToParentPath();
      }
    });
  }
}
