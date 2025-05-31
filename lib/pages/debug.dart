import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';
import 'package:dont_poop_in_my_phone/viewmodels/index.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final List<String> _logMessages = [];
  bool _isGeneratingFiles = false;
  int _numberOfDirectories = 5;
  int _numberOfFilesPerDirectory = 10;
  int _maxFileSizeKB = 100;
  String _testDirName = 'test_trash';
  String? _externalStoragePath;
  late TextEditingController _testDirNameController;
  
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    _testDirNameController = TextEditingController(text: _testDirName);
    _initDeviceInfo();
    _getStoragePath();
  }

  @override
  void dispose() {
    _testDirNameController.dispose();
    super.dispose();
  }

  Future<void> _getStoragePath() async {
    try {
      if (Platform.isAndroid) {
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          _externalStoragePath = directory.path;
        } else {
          _externalStoragePath = StarFileSystem.SDCARD_ROOT;
        }
      } else {
        final directory = await getApplicationDocumentsDirectory();
        _externalStoragePath = directory.path;
      }
      setState(() {});
    } catch (e) {
      _log('获取存储路径失败: $e');
      _externalStoragePath = StarFileSystem.SDCARD_ROOT;
      setState(() {});
    }
  }

  Future<void> _initDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        _deviceData = _readAndroidDeviceInfo(await _deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _deviceData = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
      }
      setState(() {});
    } catch (e) {
      _log('获取设备信息失败: $e');
    }
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    return {
      '设备型号': info.model,
      '制造商': info.manufacturer,
      'Android版本': info.version.release,
      'SDK版本': info.version.sdkInt.toString(),
      '设备ID': info.id,
      '系统版本': info.version.baseOS ?? '未知',
      '屏幕密度': window.devicePixelRatio.toStringAsFixed(2),
      '屏幕尺寸': '${window.physicalSize.width.toInt()} x ${window.physicalSize.height.toInt()}',
      '存储路径': _externalStoragePath ?? '未知',
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    return {
      '设备名称': info.name ?? '未知',
      '设备型号': info.model ?? '未知',
      '系统名称': info.systemName ?? '未知',
      '系统版本': info.systemVersion ?? '未知',
      '设备ID': info.identifierForVendor ?? '未知',
      '存储路径': _externalStoragePath ?? '未知',
    };
  }

  void _log(String message) {
    setState(() {
      _logMessages.add('${DateTime.now().toString().substring(0, 19)}: $message');
    });
  }

  Future<void> _generateTestFiles() async {
    if (_isGeneratingFiles) return;
    
    setState(() {
      _isGeneratingFiles = true;
      _logMessages.clear();
    });
    
    _log('开始生成测试文件...');
    
    String targetBaseDir;

    if (Platform.isAndroid) {
      targetBaseDir = StarFileSystem.SDCARD_ROOT;
      _log('Android 平台：测试文件将在 $targetBaseDir/$_testDirName 下生成');
    } else if (Platform.isIOS) {
      if (_externalStoragePath == null) {
        _log('错误: iOS未能获取应用文档目录路径');
        setState(() => _isGeneratingFiles = false);
        return;
      }
      targetBaseDir = _externalStoragePath!;
      _log('iOS 平台：测试文件将在 $targetBaseDir/$_testDirName 下生成');
    } else {
      // Fallback for other platforms
      if (_externalStoragePath == null) {
        _log('错误: 未能获取存储路径用于不受支持的平台');
        setState(() => _isGeneratingFiles = false);
        return;
      }
      targetBaseDir = _externalStoragePath!;
      _log('警告: 在不受支持的平台上使用默认存储路径: $targetBaseDir/$_testDirName');
    }
    
    final testBasePath = path.join(targetBaseDir, _testDirName);
    
    try {
      // 创建测试根目录
      final baseDir = Directory(testBasePath);
      if (await baseDir.exists()) {
        _log('清理已存在的测试目录...');
        await baseDir.delete(recursive: true);
      }
      
      await baseDir.create(recursive: true);
      _log('已创建测试根目录: $testBasePath');
      
      final random = Random();
      
      // 创建子目录和文件
      for (int dirIndex = 1; dirIndex <= _numberOfDirectories; dirIndex++) {
        final dirName = 'trash_dir_$dirIndex';
        final dirPath = path.join(testBasePath, dirName);
        final dir = await Directory(dirPath).create();
        _log('已创建目录: $dirPath');
        
        // 在每个目录中创建随机文件
        for (int fileIndex = 1; fileIndex <= _numberOfFilesPerDirectory; fileIndex++) {
          final fileName = 'trash_file_$fileIndex.txt';
          final filePath = path.join(dirPath, fileName);
          final file = File(filePath);
          
          // 生成随机内容
          final fileSize = random.nextInt(_maxFileSizeKB * 1024);
          final sb = StringBuffer();
          for (int i = 0; i < fileSize; i++) {
            sb.write(String.fromCharCode(random.nextInt(26) + 97)); // a-z
          }
          
          await file.writeAsString(sb.toString());
          _log('已创建文件: $filePath (${StarFileSystem.formatFileSize(fileSize)})');
        }
      }
      
      _log('测试文件生成完成! 共创建 $_numberOfDirectories 个目录，每个目录包含 $_numberOfFilesPerDirectory 个文件');
      BotToast.showText(text: '测试文件生成完成!');
    } catch (e) {
      _log('生成测试文件时出错: $e');
      BotToast.showText(text: '生成测试文件失败: $e');
    } finally {
      setState(() => _isGeneratingFiles = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('调试工具'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: '清除日志',
            onPressed: () => setState(() => _logMessages.clear()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDeviceInfoCard(),
                const SizedBox(height: 16),
                _buildFileGeneratorCard(),
                const SizedBox(height: 16),
                _buildLogViewer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '设备信息',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                Icon(
                  Icons.smartphone_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const Divider(),
            ..._deviceData.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      '${entry.key}:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${entry.value}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFileGeneratorCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '测试文件生成器',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                Icon(
                  Icons.create_new_folder_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: '测试目录名称',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: _testDirNameController,
              onChanged: (value) {
                _testDirName = value;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildNumberSlider(
                    '目录数量', 
                    _numberOfDirectories.toDouble(), 
                    1, 
                    20,
                    (value) => setState(() => _numberOfDirectories = value.round()),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildNumberSlider(
                    '每目录文件数', 
                    _numberOfFilesPerDirectory.toDouble(), 
                    1, 
                    50,
                    (value) => setState(() => _numberOfFilesPerDirectory = value.round()),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildNumberSlider(
                    '最大文件大小 (KB)', 
                    _maxFileSizeKB.toDouble(), 
                    1, 
                    1024,
                    (value) => setState(() => _maxFileSizeKB = value.round()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: _isGeneratingFiles 
                  ? SizedBox(
                      width: 20, 
                      height: 20, 
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ) 
                  : const Icon(Icons.file_copy_rounded),
                label: Text(_isGeneratingFiles ? '生成中...' : '生成测试文件'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isGeneratingFiles ? null : _generateTestFiles,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.round().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: max.toInt(),
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildLogViewer() {
    return SizedBox(
      height: 300,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '操作日志',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold, 
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  Icon(
                    Icons.text_snippet_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    itemCount: _logMessages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = _logMessages[_logMessages.length - 1 - index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: message.contains('错误') || message.contains('失败') 
                                ? Colors.red 
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      );
                    },
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