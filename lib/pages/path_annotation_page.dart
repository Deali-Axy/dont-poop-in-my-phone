import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:dont_poop_in_my_phone/pages/add_annotation_page.dart';

class PathAnnotationPage extends StatefulWidget {
  const PathAnnotationPage({Key? key}) : super(key: key);

  @override
  _PathAnnotationPageState createState() => _PathAnnotationPageState();
}

class _PathAnnotationPageState extends State<PathAnnotationPage> {
  List<PathAnnotation> _annotations = [];
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadAnnotations();
  }
  
  Future<void> _loadAnnotations() async {
    setState(() => _isLoading = true);
    try {
      _annotations = await PathAnnotationDao.getAll();
    } catch (e) {
      ErrorHandler().handleGeneralError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('路径标注管理'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnnotations,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAnnotation,
        child: const Icon(Icons.add),
        tooltip: '添加新标注',
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _annotations.isEmpty 
          ? _buildEmptyView() 
          : _buildAnnotationList(),
    );
  }
  
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.label_off_rounded,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无路径标注',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _addNewAnnotation, 
            icon: const Icon(Icons.add), 
            label: const Text('添加标注'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnnotationList() {
    return ListView.builder(
      itemCount: _annotations.length,
      padding: const EdgeInsets.only(bottom: 96),
      itemBuilder: (context, index) {
        final annotation = _annotations[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: annotation.isBuiltIn 
              ? BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5), width: 1.5)
              : BorderSide.none,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: annotation.suggestDelete 
                  ? Colors.red.withOpacity(0.1) 
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                annotation.suggestDelete 
                  ? Icons.delete_outline 
                  : Icons.label_outline,
                color: annotation.suggestDelete 
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ),
            title: Text(
              annotation.path,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  annotation.description,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Chip(
                      backgroundColor: annotation.isBuiltIn 
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                      label: Text(
                        annotation.isBuiltIn ? '内置标注' : '用户标注',
                        style: TextStyle(
                          color: annotation.isBuiltIn 
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      backgroundColor: annotation.suggestDelete 
                        ? Colors.red.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                      label: Text(
                        annotation.suggestDelete ? '建议删除' : '不建议删除',
                        style: TextStyle(
                          color: annotation.suggestDelete 
                            ? Colors.red
                            : Colors.green[700],
                          fontSize: 12,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
            trailing: annotation.isBuiltIn
              ? null  // 内置标注不提供删除/编辑选项
              : PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: StarTextButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        text: '编辑',
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: StarTextButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        text: '删除',
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 'edit') {
                      _editAnnotation(annotation);
                    } else if (value == 'delete') {
                      _deleteAnnotation(annotation);
                    }
                  },
                ),
            onTap: annotation.isBuiltIn ? null : () => _editAnnotation(annotation),
          ),
        );
      },
    );
  }
  
  Future<void> _addNewAnnotation() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddAnnotationPage(),
      ),
    );
    
    if (result == true) {
      _loadAnnotations();
    }
  }
  
  Future<void> _editAnnotation(PathAnnotation annotation) async {
    if (annotation.isBuiltIn) return; // 内置标注不允许编辑
    
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddAnnotationPage(
          initialAnnotation: annotation,
        ),
      ),
    );
    
    if (result == true) {
      _loadAnnotations();
    }
  }
  
  Future<void> _deleteAnnotation(PathAnnotation annotation) async {
    if (annotation.isBuiltIn) return; // 内置标注不允许删除
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除路径 "${annotation.path}" 的标注吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    
    if (confirm == true && annotation.id != null) {
      setState(() => _isLoading = true);
      try {
        await PathAnnotationDao.delete(annotation.id!);
        _loadAnnotations();
      } catch (e) {
        ErrorHandler().handleGeneralError(context, e);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
} 