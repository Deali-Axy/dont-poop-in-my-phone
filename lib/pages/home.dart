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
  bool _isLoading = false;

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
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            if (_subtitle.isNotEmpty) Text(_subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : () => _goToPath(currentFolder),
          ),
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded),
            tooltip: '自动清理',
            onPressed: () => Navigator.of(context).pushNamed('clean'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const MyDrawer(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          if (!currentFolder.isRootPath) {
            _backToParentPath();
            return;
          }
          
          if (_lastWillPopAt == null || 
              DateTime.now().difference(_lastWillPopAt!) > const Duration(seconds: 1)) {
            BotToast.showText(text: '再按一次返回键退出应用~');
            // 两次点击间隔超过1秒则重新计时
            _lastWillPopAt = DateTime.now();
            return;
          }
          Navigator.of(context).pop(true);
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildNoPermissionBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_encryption_gmailerrorred_rounded,
              size: 120,
              color: Colors.red.withOpacity(0.8),
            ),
            const SizedBox(height: 24),
            const Text(
              '无法访问手机存储',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '需要存储访问权限才能执行清理操作',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('重新获取权限'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () => _goToPath(currentFolder),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text('打开系统设置'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () => openAppSettings(),
                ),
              ],
            ),
          ],
        ),
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
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 120,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              friendlyText,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_upward),
              label: const Text('返回上级目录'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: _backToParentPath,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_folders.isEmpty && _files.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_off_rounded,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              '空文件夹',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    var listviewChildren = <Widget>[];

    // 添加文件夹
    listviewChildren.addAll(_folders.map((e) => FolderCard(
          e,
          (folderItem) => _goToPath(folderItem),
          (folderItem) => _doDirAction(folderItem, ActionType.delete),
          (folderItem) => _doDirAction(folderItem, ActionType.deleteAndReplace),
        )));
    
    // 如果同时有文件夹和文件，添加分隔部分
    if (_folders.isNotEmpty && _files.isNotEmpty) {
      listviewChildren.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.insert_drive_file_outlined, color: Colors.grey),
            const SizedBox(width: 8),
            const Text(
              '文件',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Divider(
                indent: 8,
                endIndent: 8,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ));
    }
    
    // 添加文件
    listviewChildren.addAll(_files.map((e) => FileCard(
          e,
          (fileItem) => _doFileAction(fileItem, ActionType.deleteAndReplace),
          (fileItem) => _doFileAction(fileItem, ActionType.delete),
        )));

    return Column(
      children: [
        if (_folderStack.length > 1) _buildBreadCrumb(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: listviewChildren.length,
            itemBuilder: (context, index) => listviewChildren[index],
          ),
        ),
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
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: BreadCrumb.builder(
          itemCount: _folderStack.length,
          builder: (index) {
            var dirName = _folderStack[index].dirName;
            if (dirName == '0') dirName = '根目录';
  
            return BreadCrumbItem(
              content: Text(
                dirName,
                style: TextStyle(
                  fontWeight: index == _folderStack.length - 1 ? FontWeight.bold : FontWeight.normal,
                  color: index == _folderStack.length - 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              onTap: () => _goToStackIndex(index),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            );
          },
          divider: Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }

  /// 处理文件夹操作
  Future _doDirAction(FolderItem folderItem, ActionType actionType) async {
    var title = actionType == ActionType.deleteAndReplace ? '删除并替换目录' : '删除目录';
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text('确定要${actionType == ActionType.deleteAndReplace ? "删除并替换" : "删除"}目录 ${folderItem.dirName} 吗？'),
        actions: [
          TextButton(
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FilledButton(
            child: const Text('确定'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    
    if (result != true) return;

    setState(() {
      _isLoading = true;
    });
    
    try {
      await folderItem.delete(replace: actionType == ActionType.deleteAndReplace);

      _folders.remove(folderItem);
      // 替换的话，把目录加到文件那里去
      if (actionType == ActionType.deleteAndReplace) {
        _files.add(FileItem(folderItem.folderPath));
      }
      BotToast.showText(text: '处理文件夹 ${folderItem.dirName} 完成！');
    } catch (ex) {
      ErrorHandler().handleGeneralError(context, ex);
    } finally {
      setState(() {
        _isLoading = false;
        _updateTitleBar();
      });
    }
  }

  /// 处理文件操作
  Future _doFileAction(FileItem fileItem, ActionType actionType) async {
    var title = actionType == ActionType.deleteAndReplace ? '删除并替换文件' : '删除文件';
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text('确定要${actionType == ActionType.deleteAndReplace ? "删除并替换" : "删除"}文件 ${fileItem.fileName} 吗？'),
        actions: [
          TextButton(
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FilledButton(
            child: const Text('确定'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    
    if (result != true) return;

    setState(() {
      _isLoading = true;
    });
    
    try {
      await fileItem.delete(replace: actionType == ActionType.deleteAndReplace);
      _files.remove(fileItem);
      BotToast.showText(text: '处理文件 ${fileItem.fileName} 完成！');
    } catch (ex) {
      ErrorHandler().handleGeneralError(context, ex);
    } finally {
      setState(() {
        _isLoading = false;
        _updateTitleBar();
      });
    }
  }

  /// 跳转到指定路径
  Future _goToPath(FolderItem folderItem) async {
    try {
      setState(() {
        _isLoading = true;
        _exception = null;
      });

      if (!_hasPermission) {
        await requestPermission();
        if (!_hasPermission) return;
      }

      // 如果是根目录，就清空堆栈，开始入栈
      if (folderItem.isRootPath) {
        _folderStack.clear();
      }

      // 先尝试打开目录，如果目录不存在就返回
      var directory = Directory(folderItem.folderPath);
      if (!directory.existsSync()) {
        setState(() {
          _isLoading = false;
          _exception = FileSystemException('目录不存在');
        });
        return;
      }

      // 获取对应目录的文件夹和文件
      _folders = FolderItem.getFolderItems(folderItem.folderPath);
      _files = FileItem.getFileItems(folderItem.folderPath);

      // 入栈
      if (_folderStack.any((element) => element.folderPath == folderItem.folderPath)) {
        // 如果堆栈中有这一项(意味着点了面包屑)
        // 就从栈中删除目标元素及之后的所有元素，直到目标元素成为栈顶
        var index = _folderStack.indexWhere((element) => element.folderPath == folderItem.folderPath);
        _folderStack.removeRange(index + 1, _folderStack.length);
      } else {
        _folderStack.add(folderItem);
      }

      _updateTitleBar();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _exception = e as Exception;
      });
    }
  }

  /// 后退栈
  void _goToStackIndex(int index) {
    if (index < 0 || index >= _folderStack.length) return;

    _goToPath(_folderStack[index]);
  }

  /// 返回上一级目录
  void _backToParentPath() {
    if (_folderStack.length <= 1) return; // 已经到了根目录，不能继续返回

    _folderStack.removeLast(); // 移除栈顶
    _goToPath(_folderStack.removeLast()); // 移除当前栈顶并打开，会自动入栈
  }

  /// 更新标题栏
  void _updateTitleBar() {
    if (currentFolder.isRootPath) {
      _subtitle = '';
    } else {
      _subtitle = '当前位置：${currentFolder.folderPath}';
    }
  }
}
