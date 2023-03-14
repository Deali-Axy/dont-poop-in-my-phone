import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/contrib/hitokoto/hitokoto_generator.dart';
import 'package:dont_poop_in_my_phone/contrib/hitokoto/models/hitokoto.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  static const _backgroundImageUrl = 'https://blog.sblt.deali.cn:9000/Api/PicLib/Random/600/450';
  var _currentHitokoto = Hitokoto(
    hitokoto: '（正在加载一言）',
    creator: '别在我的手机里拉屎！',
  );

  @override
  void initState() {
    super.initState();
    _loadHitokoto();
  }

  void _loadHitokoto() async {
    _currentHitokoto = await HitokotoGenerator.getHitokoto(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader2(context),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined, size: 35),
            title: Text('清理'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.list_alt, size: 35),
            title: Text('白名单'),
            onTap: () => Navigator.of(context).pushNamed('white_list'),
          ),
          ListTile(
            leading: const Icon(Icons.rule, size: 35),
            title: Text('清理规则'),
            onTap: () => Navigator.of(context).pushNamed('rule'),
          ),
          ListTile(
            leading: const Icon(Icons.history, size: 35),
            title: Text('历史记录'),
            onTap: () => Navigator.of(context).pushNamed('history'),
          ),
          Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.help_outline, size: 35),
            title: Text('帮助'),
            onTap: () => Navigator.of(context).pushReplacementNamed('introview'),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, size: 35),
            title: Text('关于'),
            onTap: () => Navigator.of(context).pushNamed('about'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(top: 40, bottom: 20, right: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipOval(
              child: Image.asset('assets/icon/icon.png', width: 60),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 用户名
                Text(
                  _currentHitokoto.creator,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                // 个性签名
                Text(
                  _currentHitokoto.hitokoto,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  softWrap: true,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader2(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        _currentHitokoto.creator,
        style: TextStyle(fontSize: 20),
      ),
      accountEmail: Container(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          _currentHitokoto.hitokoto,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12),
        ),
      ),
      currentAccountPicture: Image.asset('assets/icon/icon.png', width: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          image: NetworkImage(_backgroundImageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
