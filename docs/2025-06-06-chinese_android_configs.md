# 中国Android环境配置说明

## 概述

为了方便中国用户快速上手扫地喵App，我们针对中国的Android应用环境，预设了常用的垃圾清理路径白名单、清理规则和路径标注。这些配置基于中国用户常用的应用程序和使用习惯进行优化。

## 新增功能

### 1. 扩展白名单配置

在原有系统白名单基础上，新增了以下保护路径：

#### 重要应用数据目录
- `/storage/emulated/0/wechat` - 微信数据目录
- `/storage/emulated/0/tencent/micromsg` - 微信聊天记录
- `/storage/emulated/0/tencent/qq_database` - QQ数据库
- `/storage/emulated/0/tencent/qqfile_recv` - QQ接收文件
- `/storage/emulated/0/alipay` - 支付宝数据
- `/storage/emulated/0/taobao` - 淘宝数据
- `/storage/emulated/0/dingtalk` - 钉钉数据

#### 银行和支付应用
- `/storage/emulated/0/icbc` - 工商银行
- `/storage/emulated/0/ccb` - 建设银行
- `/storage/emulated/0/cmb` - 招商银行
- `/storage/emulated/0/abc` - 农业银行
- `/storage/emulated/0/boc` - 中国银行

#### 重要备份和游戏存档
- `/storage/emulated/0/backup` - 备份目录
- `/storage/emulated/0/titanium_backup` - 钛备份
- `/storage/emulated/0/gameloft` - Gameloft游戏
- `/storage/emulated/0/netease` - 网易游戏
- `/storage/emulated/0/tencent/games` - 腾讯游戏

### 2. 智能清理规则

针对中国常用应用，预设了以下清理规则：

#### 高优先级清理（优先级8-10）
- 临时文件目录 (`/temp`, `/cache`, `/.cache`)
- 广告和统计数据 (`/umeng`, `/baidu/mobads`, `/tencent/beacon`)
- 日志文件 (`*.log`, `*.tmp`)
- 崩溃报告 (`/crash`, `/tombstones`)

#### 中优先级清理（优先级5-7）
- 浏览器缓存 (UC、QQ浏览器等)
- 社交应用缓存 (微信日志、QQ缓存、微博缓存)
- 视频应用缓存 (优酷、爱奇艺、腾讯视频、抖音)
- 音乐应用缓存 (网易云音乐、QQ音乐)
- 购物应用缓存 (淘宝、京东)

#### 低优先级清理（优先级4及以下）
- 游戏缓存 (腾讯游戏、网易游戏)

### 3. 路径标注系统

为用户提供详细的路径说明，帮助理解各目录的用途：

#### 系统重要目录
- Android系统目录说明
- 应用数据目录警告
- 媒体文件目录提示

#### 应用特定目录
- 腾讯系应用目录说明
- 游戏数据目录警告
- 备份目录重要性提示

#### 可清理目录
- 缓存目录清理建议
- 临时文件清理说明
- 日志文件清理提示

## 配置管理功能

### 访问方式
1. 打开扫地喵App
2. 点击左上角菜单按钮
3. 选择"配置管理"

### 主要功能

#### 配置统计
- 查看当前白名单、清理规则、路径标注的数量
- 区分内置配置和用户自定义配置

#### 配置更新
- **更新白名单配置**：添加最新的保护路径，不会删除现有配置
- **更新清理规则**：添加最新的垃圾清理规则
- **更新路径标注**：添加最新的路径说明
- **重置为默认配置**：恢复所有配置为出厂设置（谨慎使用）

#### 安全机制
- 配置更新采用增量方式，不会覆盖用户自定义配置
- 重置操作需要用户确认
- 所有操作都有详细的反馈信息

## 技术实现

### 文件结构
```
lib/
├── common/
│   └── default_configs.dart          # 默认配置定义
├── services/
│   └── config_service.dart           # 配置管理服务
├── pages/
│   └── config_management.dart        # 配置管理页面
└── database/
    └── database_manager.dart          # 数据库初始化（已更新）
```

### 核心类说明

#### DefaultConfigs
- `EXTENDED_WHITELIST_PATHS`：扩展白名单路径列表
- `getDefaultCleanRules()`：获取默认清理规则
- `getDefaultPathAnnotations()`：获取默认路径标注
- `getExtendedWhitelistItems()`：获取扩展白名单项

#### ConfigService
- `reinitializeWhitelist()`：重新初始化白名单
- `reinitializeCleanRules()`：重新初始化清理规则
- `reinitializePathAnnotations()`：重新初始化路径标注
- `getConfigStats()`：获取配置统计信息
- `exportConfigs()`：导出配置（预留功能）
- `importConfigs()`：导入配置（预留功能）

## 使用建议

### 首次使用
1. 安装App后，系统会自动初始化所有默认配置
2. 建议先查看"配置管理"页面，了解当前配置状态
3. 可以根据个人需求在白名单中添加额外的保护路径

### 定期维护
1. 定期检查"配置管理"页面，查看是否有配置更新
2. 根据新安装的应用，手动添加重要数据目录到白名单
3. 根据使用习惯，调整清理规则的优先级

### 安全注意事项
1. 不要随意删除白名单中的路径
2. 添加新的清理规则时要谨慎，避免误删重要文件
3. 使用"重置为默认配置"功能前，建议先导出当前配置（功能开发中）

## 更新日志

### v1.0.0 (2024-01-XX)
- 新增中国Android环境默认配置
- 新增配置管理页面
- 新增配置服务模块
- 扩展白名单路径覆盖常用中国应用
- 新增智能清理规则，支持优先级管理
- 新增详细的路径标注系统

## 反馈和建议

如果您发现以下情况，欢迎反馈：
1. 重要应用目录被误删
2. 常用垃圾目录未被清理
3. 路径标注信息不准确
4. 需要添加新的应用支持

请通过App内的反馈功能或GitHub Issues提交您的建议。