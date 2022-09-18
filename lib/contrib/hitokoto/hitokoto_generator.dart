import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'models/hitokoto.dart';

/// 一言生成器
class HitokotoGenerator {
  static Random _random = Random();
  static List<Hitokoto> hitokotoList = [];

  /// 获取随机一言
  static Future<Hitokoto> getHotokoto(BuildContext context) async {
    if (hitokotoList.length == 0) {
      var rawJson = await DefaultAssetBundle.of(context).loadString("assets/json/hitokoto.json");
      List data = jsonDecode(rawJson);
      for (var item in data) {
        var hitokoto = Hitokoto.fromJson(item);
        hitokotoList.add(hitokoto);
      }
    }

    return hitokotoList[_random.nextInt(hitokotoList.length)];
  }
}
