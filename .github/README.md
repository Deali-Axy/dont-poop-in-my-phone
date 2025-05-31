# GitHub Actions 工作流说明

本项目配置了完整的 CI/CD 工作流，用于自动化构建、测试和发布 Flutter 应用。

## 🚀 工作流概览

### 1. 自动发布工作流 (`release.yml`)

**触发条件：** 推送 `v*.*.*` 格式的标签时自动触发

**功能：**
- 自动构建多架构 APK（ARM64、ARM32、x86_64）
- 构建通用 APK
- 自动发布到 GitHub Release
- 生成文件校验和
- 自动生成发布说明

**使用方法：**
```bash
# 创建并推送版本标签
git tag v1.4.3
git push origin v1.4.3
```

### 2. 手动构建工作流 (`manual-build.yml`)

**触发条件：** 手动触发

**功能：**
- 支持选择构建类型（Release/Debug）
- 支持选择目标平台
- 支持自定义版本后缀
- 生成构建摘要

**使用方法：**
1. 进入 GitHub 仓库的 Actions 页面
2. 选择 "手动构建APK" 工作流
3. 点击 "Run workflow"
4. 选择构建参数并运行

### 3. 持续集成工作流 (`ci.yml`)

**触发条件：** PR 提交或主分支推送

**功能：**
- 代码格式检查
- 静态代码分析
- 单元测试执行
- Debug APK 构建测试
- APK 大小监控
- 安全扫描

## 📋 构建产物说明

### APK 文件命名规则

- `dont-poop-in-my-phone-universal.apk` - 通用版本，适用于所有设备
- `dont-poop-in-my-phone-arm64-v8a.apk` - 64位 ARM 设备（现代手机）
- `dont-poop-in-my-phone-armeabi-v7a.apk` - 32位 ARM 设备（老旧手机）
- `dont-poop-in-my-phone-x86_64.apk` - x86_64 设备（模拟器等）

### 推荐下载

1. **普通用户：** 下载 `universal.apk`
2. **追求最小体积：** 根据设备架构下载对应的 APK
3. **不确定架构：** 下载 `universal.apk`

## ⚙️ 配置要求

### 环境要求

- Flutter 3.24.5 (stable)
- Java 17
- Android SDK

### 必要的 Secrets

工作流使用以下 GitHub Secrets：

- `GITHUB_TOKEN` - 自动提供，用于发布 Release

### 可选配置

如果需要签名 APK，需要配置：

1. 在 `android/key.properties` 中配置签名信息
2. 将签名文件添加到仓库（注意安全性）
3. 或使用 GitHub Secrets 存储签名信息

## 🔧 自定义配置

### 修改 Flutter 版本

在各个工作流文件中修改：
```yaml
- name: 设置Flutter环境
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.24.5'  # 修改这里
    channel: 'stable'
```

### 修改构建目标

在 `release.yml` 中的 `strategy.matrix.target-platform` 部分：
```yaml
strategy:
  matrix:
    target-platform:
      - android-arm64    # 保留需要的平台
      - android-arm      # 可以移除不需要的平台
      - android-x64      # 例如移除 x64 支持
```

### 修改 APK 大小阈值

在 `ci.yml` 中修改：
```yaml
# 检查APK大小是否超过阈值 (100MB)
MAX_SIZE_BYTES=104857600  # 修改这个值
```

## 📊 监控和调试

### 查看构建状态

1. 进入 GitHub 仓库的 Actions 页面
2. 查看各个工作流的运行状态
3. 点击具体的运行记录查看详细日志

### 常见问题

1. **构建失败：** 检查 Flutter 版本兼容性
2. **依赖问题：** 确保 `pubspec.yaml` 中的依赖版本正确
3. **签名问题：** 检查 `android/key.properties` 配置
4. **权限问题：** 确保 `GITHUB_TOKEN` 有足够权限

### 调试技巧

1. 使用手动构建工作流测试配置
2. 查看 CI 工作流的详细日志
3. 本地运行相同的构建命令进行调试

## 🔄 版本发布流程

1. **开发完成**
   - 确保所有测试通过
   - 更新 `pubspec.yaml` 中的版本号
   - 提交所有更改

2. **创建发布**
   ```bash
   # 更新版本号后
   git add .
   git commit -m "chore: bump version to 1.4.3"
   git tag v1.4.3
   git push origin main
   git push origin v1.4.3
   ```

3. **自动构建**
   - GitHub Actions 自动触发构建
   - 生成多架构 APK
   - 自动创建 GitHub Release

4. **发布完成**
   - 用户可以从 Release 页面下载 APK
   - 包含完整的更新说明和校验和

## 📝 注意事项

1. **标签格式：** 必须使用 `v*.*.*` 格式（如 `v1.4.3`）
2. **版本同步：** 确保 Git 标签与 `pubspec.yaml` 版本号一致
3. **构建时间：** 完整构建可能需要 10-15 分钟
4. **存储空间：** 构建产物会占用 GitHub Actions 存储空间
5. **安全性：** 不要在代码中硬编码敏感信息

## 🆘 获取帮助

如果遇到问题：

1. 查看 GitHub Actions 的运行日志
2. 检查本文档的常见问题部分
3. 在项目 Issues 中提问
4. 参考 Flutter 官方文档