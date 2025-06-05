import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/index.dart';
import 'package:dont_poop_in_my_phone/common/update.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String AppTitle = '🐱扫地喵';
  var _subtitle = '';
  var _hasPermission = false;
  DateTime? _lastWillPopAt; //上次返回退出动作时间
  var _folders = <FolderItem>[];
  var _files = <FileItem>[];
  var _folderStack = <FolderItem>[];
  Object? _exception;
  bool _isLoading = false;

  final _scrollController = ScrollController();
  final _listScrollController = ScrollController();
  final _scrollPositions = <String, double>{};

  FolderItem get currentFolder {
    if (_folderStack.isEmpty) {
      return FolderItem(StarFileSystem.SDCARD_ROOT);
    }
    return _folderStack.last;
  }

  @override
  void initState() {
    super.initState();

    // 启动就打开根目录
    _goToPath(FolderItem(StarFileSystem.SDCARD_ROOT));
    AppUpdate.checkUpdate(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  Future<void> requestPermission() async {
    if (!mounted) return;
    _hasPermission = await PermissionService.request();
    if (!mounted) return;

    setState(() {
      if (_hasPermission) {
        if (_folderStack.isNotEmpty) {
          _goToPath(currentFolder);
        } else {
          _goToPath(FolderItem(StarFileSystem.SDCARD_ROOT));
        }
      }
    });
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
            onPressed: _isLoading ? null : () {
               if (_folderStack.isNotEmpty) {
                _goToPath(currentFolder);
              } else {
                _goToPath(FolderItem(StarFileSystem.SDCARD_ROOT));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded),
            tooltip: '自动清理',
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.clean),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const MyDrawer(),
      extendBody: true,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          if (_folderStack.length > 1 && !currentFolder.isRootPath) {
            _backToParentPath();
            return;
          }
          
          if (_lastWillPopAt == null || 
              DateTime.now().difference(_lastWillPopAt!) > const Duration(seconds: 1)) {
            BotToast.showText(text: '再按一次返回键退出应用~');
            _lastWillPopAt = DateTime.now();
            return;
          }
          SystemNavigator.pop();
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
                  onPressed: () => _goToPath(FolderItem(StarFileSystem.SDCARD_ROOT)),
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

  Widget _buildErrorBody(Object? error) {
    String friendlyText;
    if (error is FileSystemException) {
      friendlyText = '文件系统错误: ${error.path}\n${error.osError?.message ?? error.message}';
    } else if (error is Exception) {
      friendlyText = '发生错误: ${error.toString()}';
    } else if (error != null) {
      friendlyText = '发生内部错误，请稍后重试。 (${error.runtimeType})';
    } else {
      friendlyText = '发生未知错误';
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
              onPressed: _folderStack.length > 1 ? _backToParentPath : null,
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
              color: Colors.grey.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              '空文件夹',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.withOpacity(0.9),
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
    
    if (_folders.isNotEmpty && _files.isNotEmpty) {
      listviewChildren.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.insert_drive_file_outlined, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              '文件',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const Expanded(
              child: Divider(
                indent: 12,
                endIndent: 8,
                thickness: 0.8,
              ),
            ),
          ],
        ),
      ));
    }
    
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
            controller: _listScrollController,
            padding: const EdgeInsets.only(bottom: 72, top: 4),
            itemCount: listviewChildren.length,
            itemBuilder: (context, index) => listviewChildren[index],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (!_hasPermission && !_isLoading) {
      return _buildNoPermissionBody();
    }

    if (_exception != null) {
      return _buildErrorBody(_exception);
    }
    return _buildNormalBody();
  }

  Widget _buildBreadCrumb() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
            final bool isLast = index == _folderStack.length - 1;
  
            return BreadCrumbItem(
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  dirName,
                  style: TextStyle(
                    fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                    color: isLast
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: isLast ? null : () => _goToStackIndex(index),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            );
          },
          divider: Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            size: 22,
          ),
        ),
      ),
    );
  }

  Future _doDirAction(FolderItem folderItem, ActionType actionType) async {
    if (!mounted) return;
    var title = actionType == ActionType.deleteAndReplace ? '删除并替换目录' : '删除目录';
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text('确定要${actionType == ActionType.deleteAndReplace ? "删除并替换" : "删除"}目录 "${folderItem.dirName}" 吗？此操作不可恢复。'),
        actions: [
          TextButton(
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FilledButton.tonal(
            child: const Text('确定'),
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.8)),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    
    if (result != true) return;
    if (!mounted) return;

    setState(() => _isLoading = true);
    
    try {
      await folderItem.delete(replace: actionType == ActionType.deleteAndReplace);
      if (!mounted) return;

      setState(() {
        _folders.remove(folderItem);
        if (actionType == ActionType.deleteAndReplace) {
          _files.add(FileItem(folderItem.folderPath));
          _files.sort((a, b) => a.fileName.compareTo(b.fileName));
        }
      });
      BotToast.showText(text: '处理文件夹 "${folderItem.dirName}" 完成！');
    } catch (ex) {
      if (mounted) ErrorHandler().handleGeneralError(context, ex);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _updateTitleBar();
        });
      }
    }
  }

  Future _doFileAction(FileItem fileItem, ActionType actionType) async {
    if (!mounted) return;
    var title = actionType == ActionType.deleteAndReplace ? '删除并替换文件' : '删除文件';
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text('确定要${actionType == ActionType.deleteAndReplace ? "删除并替换" : "删除"}文件 "${fileItem.fileName}" 吗？此操作不可恢复。'),
        actions: [
          TextButton(
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FilledButton.tonal(
            child: const Text('确定'),
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.8)),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    
    if (result != true) return;
    if (!mounted) return;
    
    setState(() => _isLoading = true);
    
    try {
      await fileItem.delete(replace: actionType == ActionType.deleteAndReplace);
      if (!mounted) return;
      setState(() => _files.remove(fileItem));
      BotToast.showText(text: '处理文件 "${fileItem.fileName}" 完成！');
    } catch (ex) {
      if (mounted) ErrorHandler().handleGeneralError(context, ex);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _updateTitleBar();
        });
      }
    }
  }

  Future<void> _goToPath(FolderItem folderItem) async {
    if (!mounted) return;
    
    // 保存当前目录的滚动位置
    if (_folderStack.isNotEmpty && _listScrollController.hasClients) {
      _scrollPositions[currentFolder.folderPath] = _listScrollController.offset;
    }

    setState(() {
      _isLoading = true;
      _exception = null;
    });

    try {
      if (!_hasPermission) {
        _hasPermission = await PermissionService.request();
        if (!mounted) return;

        if (!_hasPermission) {
          setState(() => _isLoading = false);
          return;
        }
        setState(() {}); 
      }

      if (folderItem.isRootPath) {
        _folderStack.clear();
      }

      var directory = Directory(folderItem.folderPath);
      if (!directory.existsSync()) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _exception = FileSystemException('目录不存在或无法访问', folderItem.folderPath);
        });
        return;
      }
      
      var tempFolders = await FolderItem.getFolderItems(folderItem.folderPath);
      var tempFiles = FileItem.getFileItems(folderItem.folderPath);

      if (!mounted) return;

      int existingIndex = _folderStack.indexWhere((e) => e.folderPath == folderItem.folderPath);
      if (existingIndex != -1) {
        if (existingIndex + 1 < _folderStack.length) {
          _folderStack.removeRange(existingIndex + 1, _folderStack.length);
        }
      } else {
        _folderStack.add(folderItem);
      }
      
      _folders = tempFolders;
      _files = tempFiles;
      
      _updateTitleBar();
      
      setState(() {
        _isLoading = false;
      });
      
      if (_folderStack.isNotEmpty && existingIndex == -1 && _scrollController.hasClients) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
                 _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                );
            }
        });
      }
      
      // 恢复目录的滚动位置
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_listScrollController.hasClients) {
          double? savedPosition = _scrollPositions[folderItem.folderPath];
          if (savedPosition != null) {
            _listScrollController.jumpTo(
              savedPosition.clamp(0.0, _listScrollController.position.maxScrollExtent)
            );
          } else {
            _listScrollController.jumpTo(0.0);
          }
        }
      });

    } catch (e) {
      if (!mounted) return;
      ErrorHandler().handleGeneralError(context, e);
      setState(() {
        _isLoading = false;
        _exception = e;
      });
    }
  }

  void _goToStackIndex(int index) {
    if (index < 0 || index >= _folderStack.length) return;
    if (index < _folderStack.length -1) {
       _goToPath(_folderStack[index]);
    }
  }

  void _backToParentPath() {
    if (_folderStack.length <= 1) return; 
    
    FolderItem parentItem = _folderStack[_folderStack.length - 2];
    _goToPath(parentItem);
  }

  void _updateTitleBar() {
    if (!mounted) return;
    if (_folderStack.isEmpty) {
      _subtitle = '';
    } else if (currentFolder.isRootPath) {
      _subtitle = '存储根目录';
    } else {
      _subtitle = currentFolder.dirName;
    }
  }
}
