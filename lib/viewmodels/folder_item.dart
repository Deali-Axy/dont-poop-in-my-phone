import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dont_poop_in_my_phone/utils/index.dart';

class FolderItem {
  final String folderPath;
  Directory _dir;
  String _dirName = '';
  String _label = '';
  bool _isInWhiteList;
  bool _isRootPath;

  Directory get directory => _dir;

  String get dirName => _dirName;

  String get label => _label;

  bool get isInWhiteList => _isInWhiteList;

  bool get isRootPath => _isRootPath;

  FolderItem(this.folderPath) {
    _dir = Directory(folderPath);
    _dirName = path.basename(folderPath);
    _isInWhiteList = StarFileSystem.isInWhiteList(folderPath);
    if (_isInWhiteList) {
      _label = '重要文件，不支持清理';
    }
    _isRootPath = folderPath == StarFileSystem.SDCARD_ROOT;
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
