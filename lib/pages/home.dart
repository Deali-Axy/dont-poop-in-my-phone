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
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:path/path.dart' as osPath;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String AppTitle = '别在我的手机里拉屎！';
  Future _future;
  var _subtitle = '';
  var _currentPath = StarFileSystem.SDCARD_ROOT;
  var _hasPermission = false;
  var _isRootPath = true;
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

    // requestPermission();
    _turnToPath(StarFileSystem.SDCARD_ROOT);
    AppUpdate.checkUpdate(context);
  }

  /// 请求权限
  requestPermission() async {
    _hasPermission = await PermissionService.request();
    if (_hasPermission) {
      setState(() {
        _turnToPath(StarFileSystem.SDCARD_ROOT);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppTitle),
            if (_subtitle.length > 0) Text(_subtitle, style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _turnToPath(_currentPath),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: _hasPermission ? _buildBody() : _buildNoPermissionBody(),
    );

    return WillPopScope(
      child: scaffold,
      onWillPop: () async {
        if (!_isRootPath) {
          _backToParentPath();
          return false;
        }
        if (_lastWillPopAt == null || DateTime.now().difference(_lastWillPopAt) > Duration(seconds: 1)) {
          BotToast.showText(text: '再按一次返回键退出应用~');
          // 两次点击间隔超过1秒则重新计时
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(child: Text('重新获取'), onPressed: () => _turnToPath(StarFileSystem.SDCARD_ROOT)),
              SizedBox(width: 10),
              OutlinedButton(child: Text('打开设置'), onPressed: () => openAppSettings()),
            ],
          ),
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

    return Column(
      children: [
        BreadCrumb(
          items: <BreadCrumbItem>[
            BreadCrumbItem(content: Text('Item1')),
            BreadCrumbItem(content: Text('Item2')),
            BreadCrumbItem(content: Text('Item3')),
            BreadCrumbItem(content: Text('Item4')),
            BreadCrumbItem(content: Text('Item5')),
            BreadCrumbItem(content: Text('Item6')),
            BreadCrumbItem(content: Text('Item7')),
            BreadCrumbItem(content: Text('Item8')),
            BreadCrumbItem(content: Text('Item9')),
          ],
          divider: Icon(Icons.chevron_right),
          overflow: ScrollableOverflow(
            keepLastDivider: true,
            reverse: false,
            direction: Axis.horizontal,
          ),
        ),
        Expanded(child: ListView(children: listviewChildren))
      ],
    );
  }

  Widget _buildFile(String entityPath) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.description_outlined, size: 40),
        title: Text(osPath.basename(entityPath)),
        subtitle: Text(StarFileSystem.getFileSize(entityPath)),
      ),
    );
  }

  Widget _buildDirectory(String entityPath) {
    var dirName = osPath.basename(entityPath);

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
    var dirName = osPath.basename(entityPath);

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
        StarFileSystem.createFile(entityPath);
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

  void updateSubtitle() {
    setState(() {
      _subtitle = '${_currentDirs.length}个目录，${_currentFiles.length}个文件';
    });
  }

  void _backToParentPath() {
    setState(() {
      var parentPath = osPath.dirname(_currentPath);
      _turnToPath(parentPath);
    });
  }

  Future _turnToPath(String path) async {
    _hasPermission = await PermissionService.request();
    _currentPath = path;
    _isRootPath = path == StarFileSystem.SDCARD_ROOT;
    try {
      var entities = StarFileSystem.listDir(path);
      _currentFiles.clear();
      _currentDirs.clear();
      for (var entity in entities) {
        if (FileSystemEntity.isFileSync(entity.path)) {
          _currentFiles.add(entity.path);
        } else {
          _currentDirs.add(entity.path);
        }
        // 根据名称排序
        _currentDirs.sort((a, b) => osPath.basename(a).compareTo(osPath.basename(b)));
        _currentFiles.sort((a, b) => osPath.basename(a).compareTo(osPath.basename(b)));
      }
    } on FileSystemException catch (ex) {
      BotToast.showText(text: '无权访问该目录！');
      _backToParentPath();
    } on Exception catch (ex) {
      BotToast.showText(text: '未知错误～');
    }

    updateSubtitle();
  }
}
