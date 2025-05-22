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
        icon: const Icon(Icons.add_circle_outline_rounded),
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
            icon: Icons.error_outline_rounded,
            content: '加载白名单失败: ${snapshot.error}',
            buttonText: '重试',
            onButtonPressed: () => setState(() {}),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            icon: Icons.shield_outlined,
            content: '白名单当前为空，您可以添加一些信任的路径。',
            buttonText: '立即添加',
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
          padding: const EdgeInsets.all(10.0), // Slightly increased padding
          itemCount: whitelistItems.length,
          itemBuilder: (context, index) {
            final item = whitelistItems[index];
            return Card(
              elevation: 2.5,
              margin: const EdgeInsets.symmetric(vertical: 7.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 12.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.path,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16,
                              color: item.readOnly ? Theme.of(context).disabledColor.withOpacity(0.7) : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (item.readOnly)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.lock_outline_rounded, size: 18, color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildDetailIconRow(
                      item.type == models.WhitelistType.path ? Icons.folder_zip_outlined : Icons.code_rounded, 
                      '类型', 
                      item.type == models.WhitelistType.path ? '精确路径' : '正则表达式', 
                      item.readOnly
                    ),
                    if (item.annotation.isNotEmpty)
                       _buildDetailIconRow(Icons.short_text_rounded, '标注', item.annotation, item.readOnly, maxLines: 2),
                    if (item.readOnly)
                       _buildDetailIconRow(Icons.verified_user_outlined, '来源', '系统内置', item.readOnly, valueColor: Theme.of(context).colorScheme.primary),
                    
                    if (!item.readOnly)
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.edit_note_rounded, size: 20),
                            label: Text('编辑'),
                            onPressed: () => _editWhitelistItem(item),
                             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant)
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.delete_forever_rounded, size: 20, color: Theme.of(context).colorScheme.error),
                            label: Text('删除', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                            onPressed: () => _deleteWhitelistItem(item),
                          ),
                        ],
                      )
                    else 
                        SizedBox(height: 8), // Add some space for read-only items if no buttons
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailIconRow(IconData icon, String label, String value, bool isReadOnly, {Color? valueColor, int maxLines = 1}) {
    final Color effectiveColor = isReadOnly ? Theme.of(context).disabledColor : (valueColor ?? Theme.of(context).textTheme.bodySmall!.color! );
    final Color iconColor = isReadOnly ? Theme.of(context).disabledColor.withOpacity(0.6) : Theme.of(context).colorScheme.secondary;
    final Color labelColor = isReadOnly ? Theme.of(context).disabledColor.withOpacity(0.8) : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7) ?? Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: iconColor),
          SizedBox(width: 8),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.normal, color: labelColor, fontSize: 13)),
          Expanded(child: Text(value, style: TextStyle(color: effectiveColor, fontSize: 13, fontWeight: FontWeight.w500), maxLines: maxLines, overflow: TextOverflow.ellipsis,)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Row(children: [Icon(Icons.warning_amber_rounded, color: Colors.orange), SizedBox(width:10), Text('确认删除')]),
          content: Text('您确定要从白名单中移除 "${item.path}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: Text('删除', style: TextStyle(color: Colors.white)),
               style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await WhitelistDao.deleteByPath(item.path);
        BotToast.showText(text: '白名单 "${item.path}" 已移除');
        setState(() {}); 
      } catch (e) {
        BotToast.showText(text: '移除失败: $e');
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
