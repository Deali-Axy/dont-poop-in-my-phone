import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/whitelist.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';

class WhitelistPage extends StatefulWidget {
  const WhitelistPage({Key? key}) : super(key: key);

  @override
  _WhitelistPageState createState() => _WhitelistPageState();
}

class _WhitelistPageState extends State<WhitelistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('白名单')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Whitelist>>(
      future: WhitelistDao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Empty(
            content: '加载白名单失败',
            buttonText: '返回',
            onButtonPressed: () => Navigator.of(context).pop(),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            content: '没有白名单',
            buttonText: '返回',
            onButtonPressed: () => Navigator.of(context).pop(),
          );
        }
        
        final whitelistItems = snapshot.data!;
        return ListView(
          children: whitelistItems.map((e) {
            return ListTile(
              title: Text(e.path),
              subtitle: Text(e.annotation),
              trailing: e.readOnly
                  ? null
                  : TextButton(
                      child: const Text('删除'),
                      onPressed: () async {
                        await WhitelistDao.delete(e.path);
                        setState(() {});
                        BotToast.showText(text: '已删除');
                      },
                    ),
            );
          }).toList(),
        );
      },
    );
  }
}
