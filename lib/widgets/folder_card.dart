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
  @override
  Widget build(BuildContext context) {
    var card = Card(
      child: ListTile(
        leading: Icon(Icons.folder, size: 40),
        title: Text(widget.folderItem.dirName),
        subtitle: _buildSubtitle(),
        trailing: _buildPopupMenu(),
      ),
    );

    return GestureDetector(child: card, onTap: () => widget.onCardTap(widget.folderItem));
  }

  Widget? _buildSubtitle() {
    Widget? subtitle;
    if (widget.folderItem.label.length > 0) {
      var style = TextStyle(color: Colors.grey);
      if (widget.folderItem.isInWhiteList) {
        style = TextStyle(fontWeight: FontWeight.w100);
      }
      subtitle = Text(widget.folderItem.label, style: style);
    }
    return subtitle;
  }

  Widget? _buildPopupMenu() {
    return widget.folderItem.isInWhiteList
        ? null
        : PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case 1:
                  widget.onDeleteAndReplace(widget.folderItem);
                  break;
                case 2:
                  widget.onDelete(widget.folderItem);
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuItem<int>>[
              PopupMenuItem(value: 1, child: StarTextButton(icon: const Icon(Icons.do_not_disturb), text: '删除并替换')),
              PopupMenuItem(value: 2, child: StarTextButton(icon: const Icon(Icons.delete_outline), text: '仅删除')),
            ],
          );
  }
}
