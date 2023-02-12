import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/common/update.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:path/path.dart' as osPath;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String AppTitle = '别在我的手机里拉屎！';
  var _subtitle = '';
  var _hasPermission = false;
  DateTime? _lastWillPopAt; //上次返回退出动作时间
  var _folders = <FolderItem>[];
  var _files = <FileItem>[];
  var _folderStack = <FolderItem>[];
  Exception? _exception;

  final _scrollController = ScrollController();

  FolderItem get currentFolder => _folderStack.last;

  @override
  void initState() {
    super.initState();

    // 显示状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    var systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // 启动就打开根目录
    _goToPath(FolderItem(StarFileSystem.SDCARD_ROOT));
    AppUpdate.checkUpdate(context);
  }

  /// 请求权限
  requestPermission() async {
    _hasPermission = await PermissionService.request();
    if (_hasPermission) {
      setState(() {
        _goToPath(currentFolder);
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
            onPressed: () => _goToPath(currentFolder),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: _buildBody(),
    );

    return WillPopScope(
      child: scaffold,
      onWillPop: () async {
        if (!currentFolder.isRootPath) {
          _backToParentPath();
          return false;
        }
        if (_lastWillPopAt == null || DateTime.now().difference(_lastWillPopAt!) > Duration(seconds: 1)) {
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
              OutlinedButton(child: Text('重新获取'), onPressed: () => _goToPath(currentFolder)),
              SizedBox(width: 10),
              OutlinedButton(child: Text('打开设置'), onPressed: () => openAppSettings()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBody(Exception? error) {
    String friendlyText;
    if (error is FileSystemException) {
      friendlyText = '无权访问该目录: ${error.message}';
    } else {
      friendlyText = error.toString();
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

  Widget _buildNormalBody() {
    var listviewChildren = <Widget>[];

    listviewChildren.addAll(_folders.map((e) => FolderCard(
          e,
          (folderItem) => _goToPath(folderItem),
          (folderItem) => _doDirAction(folderItem, ActionType.delete),
          (folderItem) => _doDirAction(folderItem, ActionType.deleteAndReplace),
        )));
    listviewChildren.addAll(_files.map((e) => FileCard(
          e,
          (fileItem) => _doFileAction(fileItem, ActionType.deleteAndReplace),
          (fileItem) => _doFileAction(fileItem, ActionType.delete),
        )));

    return Column(
      children: [
        if (_folderStack.length > 1) _buildBreadCrumb(),
        Expanded(child: ListView(children: listviewChildren)),
      ],
    );
  }

  Widget _buildBody() {
    if (!_hasPermission) {
      return _buildNoPermissionBody();
    }

    if (_exception != null) {
      return _buildErrorBody(_exception);
    }

    return _buildNormalBody();
  }

  Widget _buildBreadCrumb() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: BreadCrumb.builder(
        itemCount: _folderStack.length,
        builder: (index) {
          var dirName = _folderStack[index].dirName;
          if (dirName == '0') dirName = '根目录';

          return BreadCrumbItem(
            content: Text(dirName),
            onTap: () => _goToStackIndex(index),
          );
        },
        divider: Icon(
          Icons.chevron_right,
          color: Colors.red,
        ),
        overflow: ScrollableOverflow(
          keepLastDivider: false,
          reverse: false,
          direction: Axis.horizontal,
          controller: _scrollController,
        ),
      ),
    );
  }

  /// 处理文件夹操作
  Future _doDirAction(FolderItem folderItem, ActionType actionType) async {
    var title = actionType == ActionType.deleteAndReplace ? '删除并替换目录' : '删除目录';
    var result = await showDeleteDialog(context, title: title);
    if (!result) return;

    showLoading(context);
    try {
      await folderItem.delete(replace: actionType == ActionType.deleteAndReplace);

      _folders.remove(folderItem);
      // 替换的话，把目录加到文件那里去
      if (actionType == ActionType.deleteAndReplace) {
        _files.add(FileItem(folderItem.folderPath));
      }
      BotToast.showText(text: '处理文件夹 ${folderItem.dirName} 完成！');
    } catch (ex) {
      BotToast.showText(text: '处理文件夹失败！$ex');
    } finally {
      Navigator.of(context).pop();
      _updateTitleBar();
    }
  }

  /// 处理文件操作
  Future _doFileAction(FileItem fileItem, ActionType actionType) async {
    var title = actionType == ActionType.deleteAndReplace ? '删除并替换文件' : '删除文件';
    var result = await showDeleteDialog(context, title: title);
    if (!result) return;

    showLoading(context);
    try {
      await fileItem.delete(replace: actionType == ActionType.deleteAndReplace);

      _files.remove(fileItem);
      // 替换的话，加到文件那里去
      if (actionType == ActionType.deleteAndReplace) {
        _files.add(FileItem(fileItem.filepath));
      }
      BotToast.showText(text: '处理文件 ${fileItem.fileName} 完成！');
    } catch (ex) {
      BotToast.showText(text: '处理文件失败！$ex');
    } finally {
      Navigator.of(context).pop();
      _updateTitleBar();
    }
  }

  // 更新标题栏
  void _updateTitleBar() {
    setState(() {
      _subtitle = '${_folders.length}个目录，${_files.length}个文件';
    });
  }

  /// 返回上一级目录
  void _backToParentPath() {
    if (currentFolder.isRootPath) return;
    if (_folderStack.length <= 1) return;

    // 有错误的话得先清除，不然返回后还是显示错误界面
    setState(() {
      _exception = null;
    });

    _goToStackIndex(_folderStack.length - 2);
    return;
  }

  /// 跳转到指定目录
  Future _goToPath(FolderItem folderItem) async {
    _hasPermission = await PermissionService.request();

    try {
      _folders = FolderItem.getFolderItems(folderItem.folderPath);
      _files = FileItem.getFileItems(folderItem.folderPath);
    } on FileSystemException catch (ex) {
      BotToast.showText(text: '无权访问该目录！');
      _exception = ex;
    } on Exception catch (ex) {
      BotToast.showText(text: '未知错误～');
      _exception = ex;
    }

    setState(() {
      if (_folderStack.isEmpty || (_folderStack.isNotEmpty && folderItem != currentFolder)) {
        _folderStack.add(folderItem);
      }
    });

    _updateTitleBar();

    print('目录栈_folderStack: ' + _folderStack.map((e) => e.dirName).join(','));

    if (_folderStack.length > 2) {
      _animateToLast();
    }
  }

  /// 跳转到目录栈的指定层级
  Future _goToStackIndex(int index) async {
    if (index < 0 || index >= _folderStack.length) return;

    var item = _folderStack[index];
    // 目录栈里面有多个的情况下才删掉前面的，只有一个的话没必要删
    if (_folderStack.length > 1) {
      _folderStack.removeRange(index, _folderStack.length);
    }

    _goToPath(item);
  }

  void _animateToLast() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
