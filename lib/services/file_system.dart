import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

abstract class StarFileSystem {
  static const SDCARD_ROOT = '/storage/emulated/0';
  static const DIR_NAME_WHITE_LIST = [
    'android',
    'music',
    'download',
    'tencent',
    'pictures',
    'ankidroid',
    'dcim',
    'huawei',
    '.photoshare',
    'movies',
    'sounds',
    'documents',
    'data',
    'books',
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
    }

    return str;
  }

  static bool isInWhiteList(String dirpath) {
    var dirName = path.basename(dirpath).toLowerCase();
    return DIR_NAME_WHITE_LIST.contains(dirName);
  }

  static Future<FileSystemEntity> deleteDirectory(String path) {
    return Directory(path).delete(recursive: true);
  }

  static Future<FileSystemEntity> createFile(String filename) {
    var filepath = path.join(SDCARD_ROOT, filename);
    return File(filepath).create(recursive: true);
  }
}
