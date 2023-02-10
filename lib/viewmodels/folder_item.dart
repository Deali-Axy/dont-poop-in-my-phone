import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dont_poop_in_my_phone/utils/index.dart';

class FolderItem {
  final String folderPath;
  late Directory _dir;
  String _dirName = '';
  String _label = '';
  late bool _isDirNameInWhiteList;
  late bool _isRootPath;

  Directory get directory => _dir;

  String get dirName => _dirName;

  String get label => _label;

  bool get isInWhiteList {
    var parentPath = path.dirname(folderPath);
    var isParentRoot = parentPath == StarFileSystem.SDCARD_ROOT;
    return isParentRoot && _isDirNameInWhiteList;
  }

  bool get isRootPath => _isRootPath;

  FolderItem(this.folderPath) {
    _dir = Directory(folderPath);
    _dirName = path.basename(folderPath);
    _isDirNameInWhiteList = StarFileSystem.isInWhiteList(folderPath);
    _isRootPath = folderPath == StarFileSystem.SDCARD_ROOT;
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
}
