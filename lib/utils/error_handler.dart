import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class ErrorHandler {
  // 单例模式
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  /// 处理文件系统错误
  void handleFileSystemError(BuildContext? context, Exception error) {
    String message;
    if (error is FileSystemException) {
      message = '文件系统错误: ${error.message}';
    } else {
      message = '发生错误: ${error.toString()}';
    }
    
    _showError(context, message);
  }

  /// 处理通用错误
  void handleGeneralError(BuildContext? context, dynamic error) {
    String message = '发生错误: ${error.toString()}';
    _showError(context, message);
  }

  /// 显示错误信息
  void _showError(BuildContext? context, String message) {
    // 使用BotToast显示错误
    BotToast.showText(text: message);
    
    // 如果需要，可以在这里记录错误日志
    debugPrint('错误: $message');
  }
} 