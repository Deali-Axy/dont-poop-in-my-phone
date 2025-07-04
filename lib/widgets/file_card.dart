import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:dont_poop_in_my_phone/pages/index.dart';

typedef void FileActionEvent(FileItem fileItem);

class FileCard extends StatefulWidget {
  final FileItem fileItem;
  final FileActionEvent onDeleteAndReplace;
  final FileActionEvent onDelete;

  const FileCard(this.fileItem, this.onDeleteAndReplace, this.onDelete, {Key? key}) : super(key: key);

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
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
          side: widget.fileItem.annotation.isNotEmpty && widget.fileItem.suggestDelete
              ? BorderSide(color: Colors.red.withOpacity(0.5), width: 1.5)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: widget.fileItem.launch,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: _buildFileIcon(),
              title: Text(
                widget.fileItem.fileName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: widget.fileItem.annotation.isNotEmpty ? FontWeight.w600 : FontWeight.normal,
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

  /// 根据文件的 MIME-Type 来生成对应的图标
  /// MIME-Type 参考 https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
  /// 但手机上的文件与HTTP的不完全一致，比如 chemical 就是在HTTP文档中没有的
  Widget _buildFileIcon() {
    // 如果有标注，并且建议删除，则显示特殊图标
    if (widget.fileItem.annotation.isNotEmpty && widget.fileItem.suggestDelete) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Icons.delete_outline, size: 36, color: Colors.red),
      );
    }
    
    // 如果有标注，但不建议删除，显示标签图标
    if (widget.fileItem.annotation.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.label_outline, size: 36, color: Theme.of(context).colorScheme.tertiary),
      );
    }
    
    // 默认根据MIME类型显示图标
    final fullMime = lookupMimeType(widget.fileItem.filepath) ?? 'unknown';
    final tempArray = fullMime.split('/');
    final majorMime = tempArray.isEmpty ? fullMime : tempArray[0];
    var icon = Icons.insert_drive_file_outlined;
    var iconColor = Theme.of(context).colorScheme.secondary.withOpacity(0.7);
    
    switch (majorMime) {
      case 'application':
        icon = Icons.app_registration_rounded;
        iconColor = Colors.purple;
        break;
      case 'audio':
        icon = Icons.audio_file_rounded;
        iconColor = Colors.blue;
        break;
      case 'chemical':
        icon = Icons.science_rounded;
        iconColor = Colors.green;
        break;
      case 'example':
        icon = Icons.explore_rounded;
        iconColor = Colors.amber;
        break;
      case 'font':
        icon = Icons.font_download_rounded;
        iconColor = Colors.indigo;
        break;
      case 'image':
        icon = Icons.image_rounded;
        iconColor = Colors.pink;
        break;
      case 'model':
        icon = Icons.model_training_rounded;
        iconColor = Colors.teal;
        break;
      case 'text':
        icon = Icons.description_rounded;
        iconColor = Colors.lightBlue;
        break;
      case 'video':
        icon = Icons.video_file_rounded;
        iconColor = Colors.red;
        break;
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

  Widget _buildSubtitle() {
    // 如果有标注，则显示标注信息
    if (widget.fileItem.annotation.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fileItem.annotation,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: widget.fileItem.suggestDelete
                ? Colors.red.withOpacity(0.8)
                : Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          _buildFileInfo(),
        ],
      );
    }
    
    // 否则只显示文件信息
    return _buildFileInfo();
  }
  
  Widget _buildFileInfo() {
    final lastModified = DateFormat('yyyy-MM-dd HH:mm').format(widget.fileItem.file.lastModifiedSync());
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  lastModified,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.fileItem.fileSize,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) async {
        switch (value) {
          case 1:
            widget.onDeleteAndReplace(widget.fileItem);
            break;
          case 2:
            widget.onDelete(widget.fileItem);
            break;
          case 3:
            final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AddAnnotationPage(initialPath: widget.fileItem.filepath),
            ));
            if (result == true) {
              // 刷新标注信息
              if (mounted) {
                setState(() {
                  widget.fileItem.initAnnotationStatus();
                });
              }
            }
            break;
        }
      },
      itemBuilder: (context) => <PopupMenuItem<int>>[
        PopupMenuItem(value: 1, child: StarTextButton(icon: const Icon(Icons.do_not_disturb, color: Colors.red), text: '删除并替换')),
        PopupMenuItem(value: 2, child: StarTextButton(icon: const Icon(Icons.delete_outline, color: Colors.orange), text: '仅删除')),
        PopupMenuItem(value: 3, child: StarTextButton(
          icon: Icon(
            widget.fileItem.annotation.isEmpty ? Icons.label_outline : Icons.label,
            color: Colors.purple
          ), 
          text: widget.fileItem.annotation.isEmpty ? '添加标注' : '编辑标注'
        )),
      ],
    );
  }
}
