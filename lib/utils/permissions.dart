import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  /// 检查当前权限状态
  static Future<bool> checkPermissionStatus() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      
      // 创建权限数组
      var permissions = <Permission>[];
      
      // 所有安卓版本都默认添加存储权限
      permissions.add(Permission.storage);
      permissions.add(Permission.notification);
      
      // Android 11+ 需要额外添加管理外部存储权限
      if (androidInfo.version.sdkInt > 29) {
        permissions.add(Permission.manageExternalStorage);
      }
      
      try {
        // 批量检查权限状态
        for (var permission in permissions) {
          var status = await permission.status;
          if (!status.isGranted) {
            return false;
          }
        }
        return true;
      } catch (e) {
        // 如果检查失败，返回false
        return false;
      }
    }
    return true;
  }

  /// 请求权限
  static Future<bool> request() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      
      // 创建权限数组
      var permissions = <Permission>[];
      
      // 所有安卓版本都默认添加存储权限
      permissions.add(Permission.storage);
      permissions.add(Permission.notification);
      
      // Android 11+ 需要额外添加管理外部存储权限
      if (androidInfo.version.sdkInt > 29) {
        permissions.add(Permission.manageExternalStorage);
      }
      
      try {
        // 批量请求权限
        Map<Permission, PermissionStatus> statuses = await permissions.request();
        
        // 检查是否有权限被永久拒绝
        bool hasPermanentlyDenied = false;
        bool allGranted = true;
        
        for (var entry in statuses.entries) {
          if (entry.value.isPermanentlyDenied) {
            hasPermanentlyDenied = true;
          }
          if (!entry.value.isGranted) {
            allGranted = false;
          }
        }
        
        // 如果有权限被永久拒绝，引导用户到设置页面
        if (hasPermanentlyDenied) {
          openAppSettings();
          return false;
        }
        
        // Android 11+ 的 MANAGE_EXTERNAL_STORAGE 权限需要特殊处理
        if (androidInfo.version.sdkInt > 29) {
          var manageStatus = statuses[Permission.manageExternalStorage];
          if (manageStatus != null && !manageStatus.isGranted) {
            // MANAGE_EXTERNAL_STORAGE权限需要用户手动在设置中授权
            // 这里返回false，让UI引导用户到设置页面
            return false;
          }
        }
        
        return allGranted;
      } catch (e) {
        return false;
      }
    }
    return true;
  }

  /// 获取当前Android SDK版本
  static Future<int> getAndroidSdkVersion() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    return 0;
  }

  /// 是否需要MANAGE_EXTERNAL_STORAGE权限
  static Future<bool> needsManageExternalStorage() async {
    if (Platform.isAndroid) {
      final sdkVersion = await getAndroidSdkVersion();
      return sdkVersion > 29;
    }
    return false;
  }

  /// 引导用户到MANAGE_EXTERNAL_STORAGE设置页面
  static Future<void> openManageStorageSettings() async {
    if (Platform.isAndroid) {
      try {
        // 打开应用的"所有文件访问权限"设置页面
        await openAppSettings();
      } catch (e) {
        // 如果无法打开设置页面，则打开应用设置
        await openAppSettings();
      }
    }
  }

  /// 检查是否有管理所有文件的权限（Android 11+）
  static Future<bool> hasManageStoragePermission() async {
    if (Platform.isAndroid) {
      final sdkVersion = await getAndroidSdkVersion();
      if (sdkVersion > 29) {
        var manageStatus = await Permission.manageExternalStorage.status;
        return manageStatus.isGranted;
      }
    }
    return true;
  }
}
