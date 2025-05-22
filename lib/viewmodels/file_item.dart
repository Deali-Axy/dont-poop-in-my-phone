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

  File get file => _file;

  String get fileSize => _fileSize;

  String get fileName => _fileName;

  FileItem(this.filepath) {
    _file = File(filepath);
    _fileSize = StarFileSystem.formatFileSize(_file.lengthSync());
    _fileName = path.basename(filepath);
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
    list.sort((a, b) => a.fileName.compareTo(b.fileName));
    return list;
  }
}
