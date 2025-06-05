import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:flutter/material.dart';

class AddWhitelistPage extends StatefulWidget {
  final models.Whitelist? itemToEdit;

  const AddWhitelistPage({Key? key, this.itemToEdit}) : super(key: key);

  @override
  _AddWhitelistPageState createState() => _AddWhitelistPageState();
}

class _AddWhitelistPageState extends State<AddWhitelistPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _pathController;
  late TextEditingController _annotationController;
  models.WhitelistType _selectedType = models.WhitelistType.path;

  bool get _isEditMode => widget.itemToEdit != null;

  @override
  void initState() {
    super.initState();
    _pathController = TextEditingController(text: _isEditMode ? widget.itemToEdit!.path : '');
    _annotationController = TextEditingController(text: _isEditMode ? widget.itemToEdit!.annotation : '');
    if (_isEditMode) {
      _selectedType = widget.itemToEdit!.type;
    }
  }

  @override
  void dispose() {
    _pathController.dispose();
    _annotationController.dispose();
    super.dispose();
  }

  Future<void> _saveWhitelistItem() async {
    if (_formKey.currentState!.validate()) {
      final path = _pathController.text.trim();
      final annotation = _annotationController.text.trim();

      final whitelistItem = models.Whitelist(
        id: _isEditMode ? widget.itemToEdit!.id : null,
        path: path,
        type: _selectedType,
        annotation: annotation,
        readOnly: _isEditMode ? widget.itemToEdit!.readOnly : false, // New items are not read-only by default
        // createdAt and updatedAt are handled by DAO/Service
      );

      try {
        bool success = false;
        if (_isEditMode) {
          // await WhitelistDao.update(whitelistItem); // WhitelistDao.update needs to be implemented
          // For now, we can't truly update, just show a message. 
          // OR, delete and re-add if primary key (path or id) isn't changing in a way that breaks this.
          // Let's assume WhitelistDao.add will handle conflicts or we add an update method later.
          BotToast.showText(text: '白名单更新功能暂未完全实现。');
          // To simulate an update, we can try to add it (if path changes) or just pop.
          // If we allow path editing, add might create a new one. True update needs ID.
          // For now, let's prevent editing path for simplicity if not implementing full update yet.
          if (widget.itemToEdit!.path == path) { // Path not changed
             // Attempt to re-add, which will update if add handles it, or use a real update method
             await WhitelistDao.deleteByPath(widget.itemToEdit!.path); // remove old one
             final newItem = await WhitelistDao.add(whitelistItem.copyWith(id: null)); // add as new
             success = newItem !=null;
             if(success) BotToast.showText(text: '白名单已更新 (通过替换)'); else BotToast.showText(text: '更新失败');
          } else {
             final newItem = await WhitelistDao.add(whitelistItem.copyWith(id: null)); // add as new if path changed
             if (newItem != null) {
                await WhitelistDao.deleteByPath(widget.itemToEdit!.path); // delete old one
                BotToast.showText(text: '白名单已更新 (路径已更改)');
                success = true;
             } else {
                BotToast.showText(text: '更新失败 (路径更改后添加失败)');
             }
          }

        } else {
          final newItem = await WhitelistDao.add(whitelistItem);
          if (newItem != null) {
            BotToast.showText(text: '白名单已添加');
            success = true;
          } else {
            BotToast.showText(text: '添加失败 (可能已存在或路径无效)');
          }
        }
        if (success) Navigator.of(context).pop(true); // Indicate success
      } catch (e) {
        BotToast.showText(text: '操作失败: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '编辑白名单' : '添加白名单'),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt_outlined),
            onPressed: _saveWhitelistItem,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _pathController,
                decoration: InputDecoration(
                  labelText: '路径或正则表达式',
                  border: OutlineInputBorder(),
                  hintText: _selectedType == models.WhitelistType.path ? '/sdcard/example_folder' : '.*\\.log',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '路径不能为空';
                  }
                  if (_selectedType == models.WhitelistType.regex) {
                    try {
                      RegExp(value.trim());
                    } catch (e) {
                      return '无效的正则表达式';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('类型:', style: Theme.of(context).textTheme.titleMedium),
              DropdownButtonFormField<models.WhitelistType>(
                value: _selectedType,
                decoration: InputDecoration(border: OutlineInputBorder()),
                items: models.WhitelistType.values.map((type) {
                  return DropdownMenuItem<models.WhitelistType>(
                    value: type,
                    child: Text(type == models.WhitelistType.path ? '精确路径' : '正则表达式'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _annotationController,
                decoration: InputDecoration(
                  labelText: '标注 (可选)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text(_isEditMode ? '更新白名单' : '添加到白名单'),
                  onPressed: _saveWhitelistItem,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 