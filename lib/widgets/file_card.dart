import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';

class FileCard extends StatelessWidget {
  final FileItem fileItem;

  const FileCard(this.fileItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: Icon(Icons.description_outlined, size: 40),
          title: Text(fileItem.fileName),
          subtitle: Text(fileItem.fileSize),
        ),
      ),
      onTap: fileItem.launch,
    );
  }
}
