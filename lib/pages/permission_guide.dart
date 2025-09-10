import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/permissions.dart';
import '../common/routes.dart';

class PermissionGuidePage extends StatefulWidget {
  const PermissionGuidePage({Key? key}) : super(key: key);

  @override
  State<PermissionGuidePage> createState() => _PermissionGuidePageState();
}

class _PermissionGuidePageState extends State<PermissionGuidePage> with WidgetsBindingObserver {
  bool _isChecking = false;
  bool _needsManageStorage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAndroidVersion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkAndroidVersion() async {
    final needsManage = await PermissionService.needsManageExternalStorage();
    setState(() {
      _needsManageStorage = needsManage;
    });
  }

  Future<void> _requestPermission() async {
    setState(() {
      _isChecking = true;
    });

    try {
      // 先检查当前权限状态
      final hasPermission = await PermissionService.checkPermissionStatus();
      if (hasPermission) {
        _onPermissionGranted();
        return;
      }

      // 请求基础存储权限
      final granted = await PermissionService.request();
      if (granted) {
        _onPermissionGranted();
        return;
      }

      // 如果是Android 11+且基础权限已授予，但还需要管理存储权限
      if (_needsManageStorage) {
        final hasManagePermission = await PermissionService.hasManageStoragePermission();
        if (hasManagePermission) {
          _onPermissionGranted();
        } else {
          _showManageStorageGuide();
        }
      } else {
        _showPermissionDeniedDialog();
      }
    } catch (e) {
      _showErrorDialog('权限请求失败: $e');
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  void _onPermissionGranted() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _showManageStorageGuide() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('需要特殊权限'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Android 11+ 需要"所有文件访问权限"才能正常工作。'),
            SizedBox(height: 12),
            Text('请按以下步骤操作：'),
            SizedBox(height: 8),
            Text('1. 点击"去设置"按钮'),
            Text('2. 找到"所有文件访问权限"'),
            Text('3. 开启权限开关'),
            Text('4. 返回应用'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              PermissionService.openManageStorageSettings();
            },
            child: const Text('去设置'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('权限被拒绝'),
        content: const Text('扫地喵需要存储权限才能帮您清理手机垃圾，请重新授权。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _requestPermission();
            },
            child: const Text('重新授权'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('错误'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkPermissionAfterReturn() async {
    final hasPermission = await PermissionService.checkPermissionStatus();
    if (hasPermission) {
      _onPermissionGranted();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // 当应用从后台返回时，检查权限状态
      _checkPermissionAfterReturn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                // 应用图标和标题
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/icon/icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '扫地喵',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '智能清理，守护您的手机空间',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                // 权限说明卡片
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.security,
                        size: 48,
                        color: Color(0xFF6C63FF),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '需要存储权限',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _needsManageStorage
                            ? '为了帮您清理手机垃圾，扫地喵需要访问存储空间的权限。\n\nAndroid 11+ 需要在设置中手动开启"所有文件访问权限"。'
                            : '为了帮您清理手机垃圾，扫地喵需要访问存储空间的权限。\n\n我们承诺只会扫描和清理垃圾文件，不会访问您的隐私数据。',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718096),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // 授权按钮
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isChecking ? null : _requestPermission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C63FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isChecking
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF6C63FF),
                              ),
                            ),
                          )
                        : const Text(
                            '授权并开始使用',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                // 检查权限按钮（从设置返回后使用）
                TextButton(
                  onPressed: _checkPermissionAfterReturn,
                  child: const Text(
                    '我已授权，重新检查',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}