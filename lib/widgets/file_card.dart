import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';

class FileCard extends StatelessWidget {
  final FileItem fileItem;

  const FileCard(this.fileItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: _buildFileIcon(),
          title: Text(fileItem.fileName),
          subtitle: Text(fileItem.fileSize),
        ),
      ),
      onTap: fileItem.launch,
    );
  }

  /// 根据文件的 MIME-Type 来生成对应的图标
  /// MIME-Type 参考 https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
  /// 但手机上的文件与HTTP的不完全一致，比如 chemical 就是在HTTP文档中没有的
  Widget _buildFileIcon() {
    final fullMime = lookupMimeType(fileItem.filepath) ?? 'unknown';
    final tempArray = fullMime.split('/');
    final majorMime = tempArray.isEmpty ? fullMime : tempArray[0];
    var icon = Icons.description_outlined;
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
}
