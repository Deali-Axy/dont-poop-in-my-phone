import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';

typedef void FileActionEvent(FileItem fileItem);

class FileCard extends StatelessWidget {
  final FileItem fileItem;
  final FileActionEvent onDeleteAndReplace;
  final FileActionEvent onDelete;

  const FileCard(this.fileItem, this.onDeleteAndReplace, this.onDelete, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fileItem.launch,
      child: Card(
        child: ListTile(
          leading: _buildFileIcon(),
          title: Text(fileItem.fileName),
          subtitle: _buildSubtitle(),
          trailing: _buildPopupMenu(),
        ),
      ),
    );
  }

  /// 根据文件的 MIME-Type 来生成对应的图标
  /// MIME-Type 参考 https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
  /// 但手机上的文件与HTTP的不完全一致，比如 chemical 就是在HTTP文档中没有的
  Widget _buildFileIcon() {
    final fullMime = lookupMimeType(fileItem.filepath) ?? 'unknown';
    final tempArray = fullMime.split('/');
    final majorMime = tempArray.isEmpty ? fullMime : tempArray[0];
    var icon = Icons.insert_drive_file_outlined;
    switch (majorMime) {
      case 'application':
        icon = Icons.settings_applications_outlined;
        break;
      case 'audio':
        icon = Icons.audio_file_outlined;
        break;
      case 'chemical':
        icon = Icons.schema_outlined;
        break;
      case 'example':
        icon = Icons.explicit_outlined;
        break;
      case 'font':
        icon = Icons.font_download_outlined;
        break;
      case 'image':
        icon = Icons.image_outlined;
        break;
      case 'model':
        icon = Icons.model_training_outlined;
        break;
      case 'text':
        icon = Icons.text_format_outlined;
        break;
      case 'video':
        icon = Icons.video_file_outlined;
        break;
    }

    return Icon(icon, size: 40);
  }

  Widget _buildSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(DateFormat('yyyy-MM-dd H:mm').format(fileItem.file.lastModifiedSync())), Text(fileItem.fileSize)],
    );
  }

  Widget? _buildPopupMenu() {
    return PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case 1:
            onDeleteAndReplace(fileItem);
            break;
          case 2:
            onDelete(fileItem);
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
