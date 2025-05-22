import 'dart:io';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:path/path.dart' as path;
import 'package:dont_poop_in_my_phone/utils/index.dart';

class FolderItem {
  final String folderPath;
  late Directory _dir;
  String _dirName = '';
  String _label = '';
  late bool _isRootPath;
  bool _isInWhiteList = false;

  Directory get directory => _dir;

  String get dirName => _dirName;

  String get label => _label;

  bool get isInWhiteList => _isInWhiteList;

  bool get isRootPath => _isRootPath;

  FolderItem(this.folderPath) {
    _dir = Directory(folderPath);
    _dirName = path.basename(folderPath);
    _isRootPath = folderPath == StarFileSystem.SDCARD_ROOT;
    // 白名单检查现在是异步的，需要单独调用
    _isInWhiteList = false;
    _label = '';
  }

  /// 异步初始化白名单状态
  Future<void> initWhitelistStatus() async {
    _isInWhiteList = await WhitelistDao.containsPath(folderPath);
    if (_isInWhiteList) {
      _label = '重要文件，不支持清理';
    }
  }

  static Future<List<FolderItem>> getFolderItems(String parentPath) async {
    var list = StarFileSystem.listDir(parentPath)
        // 只拿出目录
        .where((e) => FileSystemEntity.isDirectorySync(e.path))
        .map((e) => FolderItem(e.path))
        .toList();

    // 异步初始化白名单状态
    await Future.wait(list.map((item) => item.initWhitelistStatus()));

    // 根据名称排序
    list.sort((a, b) => a.dirName.compareTo(b.dirName));
    return list;
  }

  Future<FileSystemEntity> delete({bool replace = false}) async {
    var entity = await directory.delete(recursive: true);
    if (replace) {
      await StarFileSystem.createFile(folderPath);
    }

    var history = History(
      name: '${replace ? '替换' : '删除'}目录: $dirName',
      path: folderPath,
      time: DateTime.now(),
      actionType: replace ? ActionType.deleteAndReplace : ActionType.delete,
    );

    // 使用数据库存储历史记录
    await HistoryDao.add(history);

    return entity;
  }
}
