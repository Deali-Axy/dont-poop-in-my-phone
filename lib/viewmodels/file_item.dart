import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
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
    try{
      OpenFilex.open(filepath);
    } on Exception catch(ex){
      BotToast.showText(text: '无法打开文件~ $ex');
    }
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
