import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';
import 'add_whitelist_page.dart'; // Import AddWhitelistPage

class WhitelistPage extends StatefulWidget {
  const WhitelistPage({Key? key}) : super(key: key);

  @override
  _WhitelistPageState createState() => _WhitelistPageState();
}

class _WhitelistPageState extends State<WhitelistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('白名单管理'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_upload_outlined),
            onPressed: () {
              // TODO: Implement batch import
              BotToast.showText(text: '批量导入功能待实现');
            },
            tooltip: '批量导入',
          ),
          IconButton(
            icon: Icon(Icons.file_download_outlined),
            onPressed: () {
              // TODO: Implement batch export
              BotToast.showText(text: '批量导出功能待实现');
            },
            tooltip: '批量导出',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddWhitelistPage())).
            then((value) {
              if (value == true) setState(() {}); // Refresh if item was added/edited
            });
        },
        label: const Text('添加白名单'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<models.Whitelist>>(
      future: WhitelistDao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Empty(
            content: '加载白名单失败: ${snapshot.error}',
            buttonText: '重试',
            onButtonPressed: () => setState(() {}),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            content: '白名单为空',
            buttonText: '添加白名单',
            onButtonPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddWhitelistPage())).
                then((value) {
                 if (value == true) setState(() {});
                });
            },
          );
        }
        
        final whitelistItems = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: whitelistItems.length,
          itemBuilder: (context, index) {
            final item = whitelistItems[index];
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.path,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: item.readOnly ? Theme.of(context).disabledColor : null),
                    ),
                    SizedBox(height: 8),
                    _buildDetailRow('类型:', item.type.toString().split('.').last, item.readOnly),
                    if (item.annotation.isNotEmpty)
                       _buildDetailRow('标注:', item.annotation, item.readOnly),
                    if (item.readOnly)
                       _buildDetailRow('状态:', '只读 (系统内置)', item.readOnly, valueColor: Theme.of(context).colorScheme.primary),
                    SizedBox(height: 10),
                    if (!item.readOnly)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                            icon: Icon(Icons.edit_outlined, size: 20),
                            label: Text('编辑'),
                            onPressed: () {
                              _editWhitelistItem(item);
                            },
                          ),
                          SizedBox(width: 8),
                          TextButton.icon(
                            style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                            icon: Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                            label: Text('删除', style: TextStyle(color: Colors.redAccent)),
                            onPressed: () => _deleteWhitelistItem(item),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, bool isReadOnly, {Color? valueColor}) {
    final Color textColor = isReadOnly ? Theme.of(context).disabledColor : (valueColor ?? Theme.of(context).textTheme.bodyMedium!.color! );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: TextStyle(fontWeight: FontWeight.w500, color: isReadOnly ? Theme.of(context).disabledColor: null)),
          Expanded(child: Text(value, style: TextStyle(color: textColor))),
        ],
      ),
    );
  }

  void _deleteWhitelistItem(models.Whitelist item) async {
    if (item.readOnly) {
      BotToast.showText(text: '无法删除只读白名单项。');
      return;
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认删除'),
          content: Text('确定要删除白名单 "${item.path}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('删除', style: TextStyle(color: Colors.red.shade700)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await WhitelistDao.deleteByPath(item.path);
        BotToast.showText(text: '白名单 "${item.path}" 已删除');
        setState(() {}); 
      } catch (e) {
        BotToast.showText(text: '删除失败: $e');
      }
    }
  }

  void _editWhitelistItem(models.Whitelist item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddWhitelistPage(itemToEdit: item))).
      then((value) {
        if (value == true) setState(() {}); // Refresh if item was added/edited
      });
  }
}
