import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const String APP_ID = 'f2054ac2-4403-4ff1-873a-24397574e847';

class AppInfo {
  String id;
  String name;
  String description;
  int version;
  String version_str;
  String update_description;
  String download_link;
  String detail_link;

  AppInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.version_str,
    required this.update_description,
    required this.download_link,
    required this.detail_link,
  });
}

abstract class AppUpdate {
  static getAppInfo() async {
    var url = 'http://www.sblt.deali.cn:15911/qapp/get';
    Map request = {'id': APP_ID};
    var dio = Dio();
    var response = await dio.post(url, data: request, options: Options(method: 'POST'));
    var data = response.data['app'];

    var appInfo = AppInfo(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        version: data['version'],
        version_str: data['version_str'],
        update_description: data['update_description'],
        download_link: data['download_link'],
        detail_link: data['detail_link']);

    return appInfo;
  }

  static Future<bool> checkUpdate(BuildContext context) async {
    print('正在检查更新……');
    AppInfo appInfo = await getAppInfo();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (appInfo.version > int.parse(packageInfo.buildNumber)) {
      await showDialog<AppInfo>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('发现新版本'),
            children: <Widget>[
              SimpleDialogOption(child: Text('名称：${appInfo.name}')),
              SimpleDialogOption(child: Text('新版本：${appInfo.version_str}')),
              // SimpleDialogOption(child: Text('简介：${appInfo.description}')),
              SimpleDialogOption(child: Text('更新说明：${appInfo.update_description}')),
              SimpleDialogOption(
                child: OutlinedButton(
                  child: Text('点击下载'),
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(appInfo.download_link))) {
                      await launchUrl(Uri.parse(appInfo.download_link));
                    } else {
                      throw 'Could not launch ${appInfo.download_link}';
                    }
                  },
                ),
              ),
            ],
          );
        },
      );
      return true;
    } else {
      return false;
    }
  }
}
