import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';
import 'package:bot_toast/bot_toast.dart';

class AddAnnotationPage extends StatefulWidget {
  final PathAnnotation? initialAnnotation;
  final String? initialPath;
  
  const AddAnnotationPage({
    Key? key,
    this.initialAnnotation,
    this.initialPath,
  }) : super(key: key);

  @override
  _AddAnnotationPageState createState() => _AddAnnotationPageState();
}

class _AddAnnotationPageState extends State<AddAnnotationPage> {
  late TextEditingController _pathController;
  late TextEditingController _descriptionController;
  bool _suggestDelete = false;
  PathMatchType _pathMatchType = PathMatchType.exact;
  bool _isSubmitting = false;
  
  @override
  void initState() {
    super.initState();
    if (widget.initialAnnotation != null) {
      _pathController = TextEditingController(text: widget.initialAnnotation!.path);
      _descriptionController = TextEditingController(text: widget.initialAnnotation!.description);
      _suggestDelete = widget.initialAnnotation!.suggestDelete;
      _pathMatchType = widget.initialAnnotation!.pathMatchType;
    } else {
      _pathController = TextEditingController(text: widget.initialPath ?? '');
      _descriptionController = TextEditingController();
    }
  }
  
  @override
  void dispose() {
    _pathController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.initialAnnotation != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? '编辑路径标注' : '添加路径标注'),
        elevation: 1,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPathField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                _buildSuggestDeleteField(),
                const SizedBox(height: 16),
                _buildPathMatchTypeField(),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _submit,
                    icon: Icon(isEditMode ? Icons.save : Icons.add),
                    label: Text(isEditMode ? '保存更改' : '添加标注'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildPathField() {
    final isEditMode = widget.initialAnnotation != null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '路径',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _pathController,
          decoration: InputDecoration(
            hintText: '请输入文件/目录路径，如 /storage/emulated/0/Download',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.folder_open),
            enabled: !isEditMode, // 编辑模式下不允许修改路径
          ),
          maxLines: 1,
        ),
        if (isEditMode)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '编辑模式下不能修改路径',
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        if (!isEditMode)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '提示：可以从文件管理页面选择文件/目录后点击"添加标注"菜单项来添加标注',
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '描述',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: '请输入标注描述信息',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.description),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
  
  Widget _buildSuggestDeleteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '操作建议',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('建议删除'),
          subtitle: Text(
            _suggestDelete 
                ? '标记为"建议删除"，这个路径的文件/目录将提示用户可以删除' 
                : '标记为"不建议删除"，表示这个路径的文件/目录应该保留',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          value: _suggestDelete,
          onChanged: (value) {
            setState(() {
              _suggestDelete = value;
            });
          },
          secondary: Icon(
            _suggestDelete ? Icons.delete_outline : Icons.shield_outlined,
            color: _suggestDelete ? Colors.red : Colors.green,
          ),
          activeColor: Colors.red,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPathMatchTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '路径匹配方式',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              RadioListTile<PathMatchType>(
                title: const Text('精确匹配'),
                subtitle: const Text('只匹配完全相同的路径'),
                value: PathMatchType.exact,
                groupValue: _pathMatchType,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pathMatchType = value;
                    });
                  }
                },
              ),
              RadioListTile<PathMatchType>(
                title: const Text('前缀匹配'),
                subtitle: const Text('匹配所有以此路径开头的文件/目录'),
                value: PathMatchType.prefix,
                groupValue: _pathMatchType,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pathMatchType = value;
                    });
                  }
                },
              ),
              RadioListTile<PathMatchType>(
                title: const Text('后缀匹配'),
                subtitle: const Text('匹配所有以此路径结尾的文件/目录'),
                value: PathMatchType.suffix,
                groupValue: _pathMatchType,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pathMatchType = value;
                    });
                  }
                },
              ),
              RadioListTile<PathMatchType>(
                title: const Text('模糊匹配'),
                subtitle: const Text('匹配包含此路径的文件/目录'),
                value: PathMatchType.fuzzy,
                groupValue: _pathMatchType,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pathMatchType = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Future<void> _submit() async {
    final path = _pathController.text.trim();
    final description = _descriptionController.text.trim();
    
    if (path.isEmpty) {
      BotToast.showText(text: '请输入路径');
      return;
    }
    
    setState(() => _isSubmitting = true);
    
    try {
      if (widget.initialAnnotation != null) {
        // 编辑模式
        final updatedAnnotation = widget.initialAnnotation!.copyWith(
          description: description,
          suggestDelete: _suggestDelete,
          pathMatchType: _pathMatchType,
        );
        
        await PathAnnotationDao.update(updatedAnnotation);
        BotToast.showText(text: '标注已更新');
      } else {
        // 添加模式
        final newAnnotation = PathAnnotation(
          path: path,
          description: description,
          suggestDelete: _suggestDelete,
          pathMatchType: _pathMatchType,
        );
        
        final result = await PathAnnotationDao.add(newAnnotation);
        if (result == null) {
          BotToast.showText(text: '标注添加失败，可能是该路径已存在内置标注');
          setState(() => _isSubmitting = false);
          return;
        }
        
        BotToast.showText(text: '标注已添加');
      }
      
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      ErrorHandler().handleGeneralError(context, e);
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
} 