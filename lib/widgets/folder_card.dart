import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';

typedef void CardTapEvent(FolderItem folderItem);
typedef void DirActionEvent(FolderItem folderItem);

class FolderCard extends StatefulWidget {
  final FolderItem folderItem;
  final CardTapEvent onCardTap;
  final DirActionEvent onDeleteAndReplace;
  final DirActionEvent onDelete;

  const FolderCard(this.folderItem, this.onCardTap, this.onDelete, this.onDeleteAndReplace, {Key? key}) : super(key: key);

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        elevation: _isHovered ? 4.0 : 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: widget.folderItem.isInWhiteList
              ? BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5), width: 1.5)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () => widget.onCardTap(widget.folderItem),
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: _buildIcon(),
              title: Text(
                widget.folderItem.dirName,
                style: TextStyle(
                  fontWeight: widget.folderItem.isInWhiteList ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
        subtitle: _buildSubtitle(),
        trailing: _buildPopupMenu(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color iconColor;
    
    if (widget.folderItem.isInWhiteList) {
      icon = Icons.folder_special_rounded;
      iconColor = Theme.of(context).colorScheme.primary;
    } else if (widget.folderItem.annotation.isNotEmpty) {
      if (widget.folderItem.suggestDelete) {
        icon = Icons.delete_outline;
        iconColor = Colors.red;
      } else {
        icon = Icons.label_outline;
        iconColor = Theme.of(context).colorScheme.tertiary;
      }
    } else {
      icon = Icons.folder_rounded;
      iconColor = Theme.of(context).colorScheme.secondary.withOpacity(0.7);
    }

    return Container(
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon, size: 36, color: iconColor),
    );
  }

  Widget? _buildSubtitle() {
    // 优先显示标注信息
    if (widget.folderItem.annotation.isNotEmpty) {
      final double fontSize = 14;
      final TextStyle style = TextStyle(
        color: widget.folderItem.suggestDelete 
          ? Colors.red.withOpacity(0.8) 
          : Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
        fontSize: fontSize,
        fontStyle: FontStyle.italic,
      );

      return Text(widget.folderItem.annotation, style: style);
    }
    
    // 没有标注则显示原来的label
    if (widget.folderItem.label.isEmpty) {
      return null;
    }

    final double fontSize = 14;
    final TextStyle style = widget.folderItem.isInWhiteList
        ? TextStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            fontSize: fontSize,
            fontStyle: FontStyle.italic,
          )
        : TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
            fontSize: fontSize,
          );

    return Text(widget.folderItem.label, style: style);
  }

  Widget? _buildPopupMenu() {
    return widget.folderItem.isInWhiteList
        ? null
        : PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) async {
              switch (value) {
                case 1:
                  widget.onDeleteAndReplace(widget.folderItem);
                  break;
                case 2:
                  widget.onDelete(widget.folderItem);
                  break;
                case 3:
                  String result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddRulePage(initialPath: widget.folderItem.folderPath),
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(result),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    action: SnackBarAction(label: '知道啦', onPressed: () {}),
                  ));
                  break;
                case 4:
                  final result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddAnnotationPage(initialPath: widget.folderItem.folderPath),
                  ));
                  if (result == true) {
                    // 刷新标注信息
                    if (mounted) {
                      setState(() {
                        widget.folderItem.initAnnotationStatus();
                      });
                    }
                  }
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuItem<int>>[
              PopupMenuItem(value: 1, child: StarTextButton(icon: const Icon(Icons.do_not_disturb, color: Colors.red), text: '删除并替换')),
              PopupMenuItem(value: 2, child: StarTextButton(icon: const Icon(Icons.delete_outline, color: Colors.orange), text: '仅删除')),
              PopupMenuItem(value: 3, child: StarTextButton(icon: const Icon(Icons.addchart, color: Colors.blue), text: '添加规则')),
              PopupMenuItem(value: 4, child: StarTextButton(
                icon: Icon(
                  widget.folderItem.annotation.isEmpty ? Icons.label_outline : Icons.label,
                  color: Colors.purple
                ), 
                text: widget.folderItem.annotation.isEmpty ? '添加标注' : '编辑标注'
              )),
            ],
          );
  }
}
