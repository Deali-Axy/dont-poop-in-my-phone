import 'dart:io';
import 'package:path/path.dart' as path;

abstract class StarFileSystem {
  static const SDCARD_ROOT = '/storage/emulated/0';

  static const PATH_WHITE_LIST = [
    SDCARD_ROOT + '/android',
    SDCARD_ROOT + '/android/data',
    SDCARD_ROOT + '/android/media',
    SDCARD_ROOT + '/android/obb',
    SDCARD_ROOT + '/music',
    SDCARD_ROOT + '/download',
    SDCARD_ROOT + '/tencent',
    SDCARD_ROOT + '/pictures',
    SDCARD_ROOT + '/ankidroid',
    SDCARD_ROOT + '/dcim',
    SDCARD_ROOT + '/huawei',
    SDCARD_ROOT + '/.photoshare',
    SDCARD_ROOT + '/movies',
    SDCARD_ROOT + '/sounds',
    SDCARD_ROOT + '/documents',
    SDCARD_ROOT + '/data',
    SDCARD_ROOT + '/books',
  ];

  static List<FileSystemEntity> listSdCard() {
    return Directory(SDCARD_ROOT).listSync();
  }

  static List<FileSystemEntity> listDir(String path) {
    return Directory(path).listSync();
  }

  static String getFileSize(String path) {
    return formatFileSize(File(path).lengthSync());
  }

  static String formatFileSize(int fileSize) {
    var str = '';

    if (fileSize < 1024) {
      str = '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      str = '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      str = '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    } else {
      str = '${(fileSize / 1024 / 1024 / 1024).toStringAsFixed(2)}GB';
    }

    return str;
  }

  /// 计算目录大小（递归计算所有子文件和子目录的大小）
  static Future<int> getDirectorySize(String dirPath) async {
    try {
      final dir = Directory(dirPath);
      if (!dir.existsSync()) return 0;
      
      int totalSize = 0;
      final entities = dir.listSync(recursive: true);
      
      for (final entity in entities) {
        try {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        } catch (e) {
          // 忽略无法访问的文件
          continue;
        }
      }
      
      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  /// 同步版本的目录大小计算（用于性能要求较高的场景）
  static int getDirectorySizeSync(String dirPath) {
    try {
      final dir = Directory(dirPath);
      if (!dir.existsSync()) return 0;
      
      int totalSize = 0;
      final entities = dir.listSync(recursive: true);
      
      for (final entity in entities) {
        try {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        } catch (e) {
          // 忽略无法访问的文件
          continue;
        }
      }
      
      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  static bool isInWhiteList(String dirPath) {
    return PATH_WHITE_LIST.contains(dirPath.toLowerCase());
  }

  static Future<FileSystemEntity> createFile(String filename) {
    var filepath = path.join(SDCARD_ROOT, filename);
    return File(filepath).create(recursive: true);
  }
}
