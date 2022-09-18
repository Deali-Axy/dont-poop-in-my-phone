import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dont_poop_in_my_phone/common/update.dart';
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

      BotToast.showText(text: '需要存储权限才能扫描流氓App在手机里拉的屎~');
      var statuses = await permissions.request();
      for (var item in statuses.entries) {
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
    return Scaffold(
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
      body: FutureBuilder(
        future: _future,
        builder: (ctx, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _buildNoPermissionBody();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()));
            case ConnectionState.done:
              return snapshot.hasError ? _buildErrorBody(snapshot.error) : _buildBody(snapshot.data);
          }
          return null;
        },
      ),
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

  Widget _buildBody(List<FileSystemEntity> entities) {
    var listviewChildren = <Widget>[];
    var fileList = <FileSystemEntity>[];

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

    for (var entity in entities) {
      if (FileSystemEntity.isFileSync(entity.path)) {
        fileList.add(entity);
        continue;
      }
      listviewChildren.add(_buildDirectory(entity));
    }

    for (var entity in fileList) {
      listviewChildren.add(_buildFile(entity));
    }

    return ListView(children: listviewChildren);
  }

  Widget _buildFile(FileSystemEntity entity) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.description_outlined, size: 40),
        title: Text(path.basename(entity.path)),
        subtitle: Text(StarFileSystem.getFileSize(entity.path)),
      ),
    );
  }

  Widget _buildDirectory(FileSystemEntity entity) {
    var dirName = path.basename(entity.path);

    var menuButton = PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case 1:
            var result = await showDeleteDirDialog(context, title: '删除并替换目录');
            if (result) {
              showLoading(context);
              await StarFileSystem.deleteDirectory(entity.path);
              StarFileSystem.createFile(dirName);
              Navigator.of(context).pop();
              BotToast.showText(text: '替换文件夹 $dirName 完成！手动刷新查看效果');
            }
            break;
          case 2:
            var result = await showDeleteDirDialog(context);
            if (result) {
              showLoading(context);
              await StarFileSystem.deleteDirectory(entity.path);
              Navigator.of(context).pop();
              break;
            }
        }
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
        subtitle: StarFileSystem.isInWhiteList(entity.path) && _isRootPath ? Text('重要文件，不支持清理') : Text(entity.path),
        trailing: StarFileSystem.isInWhiteList(entity.path) && _isRootPath ? null : menuButton,
      ),
    );

    return GestureDetector(child: card, onTap: () => _turnToPath(entity.path));
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
