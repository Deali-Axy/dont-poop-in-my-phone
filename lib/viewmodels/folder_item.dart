import 'dart:io';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:path/path.dart' as path;
import 'package:dont_poop_in_my_phone/utils/index.dart';

class FolderItem {
  final String folderPath;
  late Directory _dir;
  String _dirName = '';
  String _label = '';
  late bool _isDirNameInWhiteList;
  late bool _isRootPath;
  late bool _isInWhiteList;

  Directory get directory => _dir;

  String get dirName => _dirName;

  String get label => _label;

  bool get isInWhiteList => _isInWhiteList;

  bool get isRootPath => _isRootPath;

  FolderItem(this.folderPath) {
    _dir = Directory(folderPath);
    _dirName = path.basename(folderPath);
    _isDirNameInWhiteList = StarFileSystem.isInWhiteList(folderPath);
    _isRootPath = folderPath == StarFileSystem.SDCARD_ROOT;
    _isInWhiteList = StarFileSystem.isInWhiteList(folderPath);
    if (isInWhiteList) {
      _label = '重要文件，不支持清理';
    }
  }

  static List<FolderItem> getFolderItems(String parentPath) {
    var list = StarFileSystem.listDir(parentPath)
        // 只拿出目录
        .where((e) => FileSystemEntity.isDirectorySync(e.path))
        .map((e) => FolderItem(e.path))
        .toList();
    // 根据名称排序
    list.sort((a, b) => a.dirName.compareTo(b.dirName));
    return list;
  }

  Future<FileSystemEntity> delete({bool replace = false}) async {
    var entity = await directory.delete(recursive: true);
    if (replace) {
      await StarFileSystem.createFile(folderPath);
    }

    var history = new History(
      name: '${replace ? '替换' : '删除'}目录: $dirName',
      path: folderPath,
      time: DateTime.now(),
      actionType: replace ? ActionType.deleteAndReplace : ActionType.delete,
    );
    Global.appConfig.history.add(history);
    Global.saveAppConfig();

    return entity;
  }
}
