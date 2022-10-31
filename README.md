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
flutter build apk -v --obfuscate --split-debug-info=HLQ_Struggle --split-per-abi
```


## 版本
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