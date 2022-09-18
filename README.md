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