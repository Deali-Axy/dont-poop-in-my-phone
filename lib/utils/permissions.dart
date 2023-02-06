import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  static Future<bool> request() async {
    if (!Platform.isAndroid) {
      return false;
    }

    var permissions = <Permission>[];
    var deviceInfo = DeviceInfoPlugin();
    var androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt > 29) {
      permissions.add(Permission.manageExternalStorage);
    } else {
      permissions.add(Permission.storage);
    }

    var statuses = await permissions.request();
    for (var item in statuses.entries) {
      if (item.value.isDenied) {
        BotToast.showText(text: '需要存储权限才能扫描流氓App在手机里拉的屎~');
        return false;
      }

      if (item.value.isPermanentlyDenied) {
        BotToast.showText(text: '永久拒绝权限需要到设置中手动开启！');
        openAppSettings();
        return false;
      }
    }

    return true;
  }
}
