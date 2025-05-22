import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/contrib/hitokoto/hitokoto_generator.dart';
import 'package:dont_poop_in_my_phone/contrib/hitokoto/models/hitokoto.dart';
import 'package:dont_poop_in_my_phone/states/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  static const _backgroundImageUrl = 'https://blog.sblt.deali.cn:9000/Api/PicLib/Random/600/450';
  static const _avatarImageUrl = 'https://blog.sblt.deali.cn:9000/Api/PicLib/Random/200/200';
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
    final isDarkMode = context.watch<ThemeState>().darkMode;
    
    return Drawer(
      elevation: 16.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.folder_outlined,
                  title: '文件管理',
                  onTap: () => {},
                ),
                _buildMenuItem(
                  icon: Icons.shield_outlined,
                  title: '白名单',
                  onTap: () => Navigator.of(context).pushNamed('white_list'),
                ),
                _buildMenuItem(
                  icon: Icons.rule,
                  title: '清理规则',
                  onTap: () => Navigator.of(context).pushNamed('rule'),
                ),
                _buildMenuItem(
                  icon: Icons.history,
                  title: '历史记录',
                  onTap: () => Navigator.of(context).pushNamed('history'),
                ),
                _buildMenuItem(
                  icon: Icons.bug_report_outlined,
                  title: '调试工具',
                  onTap: () => Navigator.of(context).pushNamed('debug'),
                ),
                const Divider(height: 1, thickness: 1),
                SwitchListTile(
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode, 
                    size: 28, 
                    color: isDarkMode ? Theme.of(context).colorScheme.primary : Colors.amber,
                  ),
                  title: Text(
                    '暗色模式',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: context.watch<ThemeState>().darkMode,
                  onChanged: (bool? value) => context.read<ThemeState>().darkMode = value ?? false,
                ),
                SwitchListTile(
                  secondary: Icon(
                    Icons.design_services,
                    size: 28,
                    color: context.watch<ThemeState>().material3 
                      ? Theme.of(context).colorScheme.primary 
                      : Colors.grey,
                  ),
                  title: const Text(
                    'Material 3',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: context.watch<ThemeState>().material3,
                  onChanged: (bool? value) => context.read<ThemeState>().material3 = value ?? false,
                ),
                const Divider(height: 1, thickness: 1),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: '帮助',
                  onTap: () => Navigator.of(context).pushReplacementNamed('introview'),
                ),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: '关于',
                  onTap: () => Navigator.of(context).pushNamed('about'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
        ),
        image: DecorationImage(
          image: NetworkImage(_backgroundImageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('${_avatarImageUrl}?rand=${DateTime.now().millisecondsSinceEpoch}'),
                    backgroundColor: Colors.white,
                    radius: 35,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _loadHitokoto,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    radius: 16,
                    child: Icon(
                      Icons.refresh,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _currentHitokoto.creator,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _currentHitokoto.hitokoto,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
