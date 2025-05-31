# CleanerCat

扫地喵 - 智能垃圾清理工具

扫地喵是一款专为安卓用户设计的智能垃圾清理工具。与传统清理软件不同，扫地喵不仅可以识别并清理常见的垃圾目录，还能自动在清理后为这些目录创建“只读替身”，防止流氓应用反复生成垃圾文件。

主要功能包括：

- ✨ 智能识别常见垃圾目录
- 🧹 一键清理，快速释放空间
- 🔒 清理后生成只读替身，防止垃圾再生
- 🧭 安全机制保障系统稳定不误删
- 👣 清理日志可视化，操作透明可控

关键词：

```
垃圾清理, 存储清理, 安卓清理工具, 手机空间, 清理助手, 防止垃圾再生, 只读文件, 文件替身, 清理缓存, 手机提速, 扫地喵, 防流氓App, 一键清理
```

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
### 1.3.2
- 暂时不显示主页的FAB按钮，免得覆盖下面的菜单
- 底部导航栏增加沉浸效果

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

## 错误修复：数据库访问

修复了运行时出现的 `UnimplementedError: 应该通过database_manager.dart中的扩展方法实现` 错误。

### 问题原因

原来的设计中，我们尝试使用Dart的扩展方法（extension methods）来扩展AppDatabase类的功能，但是这种方式无法覆盖原始类中的方法实现。当代码尝试访问AppDatabase的方法时，仍然调用的是原始类中的方法，而这些方法只抛出异常。

### 解决方案

1. 重构了数据库访问层设计模式：
   - 用一个完整的 `DatabaseService` 类替代扩展方法
   - 将 `DatabaseManager` 作为一个静态访问点，提供 `service` 属性

2. 修改了DAO层：
   - 将所有 `DatabaseManager.database` 的引用改为 `DatabaseManager.service`

3. 简化了 `AppDatabase` 类：
   - 移除了所有抛出 `UnimplementedError` 的方法

### 主要变更

- `database_manager.dart`: 创建新的 `DatabaseService` 类代替扩展方法
- `database.dart`: 移除不需要的方法声明
- `dao/*.dart`: 更新所有DAO类使用新的 `DatabaseService`

这种设计模式更符合依赖注入和单一职责原则，并且解决了扩展方法不能覆盖基类方法的技术限制。