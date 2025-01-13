# dont_poop_in_my_phone

别在我的手机里拉屎！

## Build

### 更新图标

>参考 https://pub.flutter-io.cn/packages/flutter_launcher_icons

```bash
flutter pub run flutter_launcher_icons:main
```

### 打包apk

```bash
flutter build apk -v --obfuscate --split-debug-info=HLQ_Struggle --split-per-abi --release
```


## 版本
### 1.3.1
- 适配 Android 15
- 增加Material3的主题切换开关（不过还没完全适配MD3）
- 移除了不兼容的 storage_space 组件

参考资料：
- Flutter 小技巧之 3.16 升级最坑 M3 默认适配技巧 - https://juejin.cn/post/7304537109850472499

### 1.3.0
- 修复了关于界面的bug
- 适配 Android 14
- 新增了自适应图标

### 1.2.10
- 目录白名单规则优化
- 主界面UI优化调整
- 支持删除和替换文件

### 1.2.9
- 修复删除和替换文件夹后标题栏不刷新的bug
- 修复次级目录白名单识别问题

### 1.2.8
- 修复了代码重构之后引入的几个bug
- 支持多种文件图标显示

### 1.2.7
- 次级目录使用返回手势可以回到上一级目录
- 支持使用外部App打开文件
- 新增面包屑导航

### 1.2.6
- 修复非根目录下替换错误的bug

### 1.2.5
- 优化操作逻辑，提高性能

### 1.2.4
- 新增退出App确认

### 1.2.3
- 适配系统深色模式

### 1.2.2
- 优化侧边栏显示
- 新增历史记录功能（为自定义规则做准备）
- 优化一言功能
- 优化检查更新功能
- 优化介绍页面
- 优化权限请求逻辑
- 时间显示优化
- 修复一些bug

### 1.2.1
- 适配旧版Android

### 1.2.0
- 适配 Android13
- 新增文件浏览功能
- 支持多级目录替换

### 1.1.2
- 优化启动界面

### 1.1.1
- 新增软件许可协议和App隐私协议
- 修复更新检测
- 图标适配

### 1.1.0
- 第一个版本发布