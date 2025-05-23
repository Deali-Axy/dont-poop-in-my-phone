import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;

class FileItem {
  final String filepath;
  late File _file;
  late String _fileSize;
  late String _fileName;
  
  // 标注相关属性
  String _annotation = '';
  bool _suggestDelete = false;

  File get file => _file;

  String get fileSize => _fileSize;

  String get fileName => _fileName;
  
  // 标注相关getter
  String get annotation => _annotation;
  bool get suggestDelete => _suggestDelete;

  FileItem(this.filepath) {
    _file = File(filepath);
    _fileSize = StarFileSystem.formatFileSize(_file.lengthSync());
    _fileName = path.basename(filepath);
    // 标注初始化
    _annotation = '';
    _suggestDelete = false;
  }
  
  /// 异步初始化标注状态
  Future<void> initAnnotationStatus() async {
    final annotation = await PathAnnotationDao.getByPath(filepath);
    if (annotation != null) {
      _annotation = annotation.description;
      _suggestDelete = annotation.suggestDelete;
    }
  }

  launch() async {
    try {
      OpenFilex.open(filepath);
    } on Exception catch (ex) {
      BotToast.showText(text: '无法打开文件~ $ex');
    }
  }

  Future<FileSystemEntity> delete({bool replace = false}) async {
    var entity = await file.delete(recursive: true);
    if (replace) {
      await StarFileSystem.createFile(filepath);
    }

    var history = History(
      name: '${replace ? '替换' : '删除'}文件: $fileName',
      path: filepath,
      time: DateTime.now(),
      actionType: replace ? ActionType.deleteAndReplace : ActionType.delete,
    );

    // 使用数据库存储历史记录
    await HistoryDao.add(history);

    return entity;
  }

  static List<FileItem> getFileItems(String parentPath) {
    var list = StarFileSystem.listDir(parentPath)
        // 拿出文件
        .where((e) => FileSystemEntity.isFileSync(e.path))
        .map((e) => FileItem(e.path))
        .toList();
    
    // 异步初始化标注状态
    // 注意：这里使用了异步操作，但返回的是同步结果
    // 标注数据将在UI渲染后异步加载
    for (var file in list) {
      file.initAnnotationStatus();
    }
    
    list.sort((a, b) => a.fileName.compareTo(b.fileName));
    return list;
  }
}
