/// 默认配置文件 - 适用于中国Android应用环境
/// 包含常用的垃圾清理路径白名单、清理规则、路径标注

import '../models/index.dart';
import '../utils/file_system.dart';

class DefaultConfigs {
  /// 扩展的白名单路径 - 针对中国常用应用
  static const List<String> EXTENDED_WHITELIST_PATHS = [
    // 系统核心目录
    StarFileSystem.SDCARD_ROOT + '/system',
    StarFileSystem.SDCARD_ROOT + '/.android_secure',
    
    // 重要应用数据目录
    StarFileSystem.SDCARD_ROOT + '/wechat',
    StarFileSystem.SDCARD_ROOT + '/tencent/micromsg',
    StarFileSystem.SDCARD_ROOT + '/tencent/qq_database',
    StarFileSystem.SDCARD_ROOT + '/tencent/qqfile_recv',
    StarFileSystem.SDCARD_ROOT + '/alipay',
    StarFileSystem.SDCARD_ROOT + '/taobao',
    StarFileSystem.SDCARD_ROOT + '/tmall',
    StarFileSystem.SDCARD_ROOT + '/dingtalk',
    
    // 银行和支付应用
    StarFileSystem.SDCARD_ROOT + '/icbc',
    StarFileSystem.SDCARD_ROOT + '/ccb',
    StarFileSystem.SDCARD_ROOT + '/cmb',
    StarFileSystem.SDCARD_ROOT + '/abc',
    StarFileSystem.SDCARD_ROOT + '/boc',
    
    // 重要文档和备份
    StarFileSystem.SDCARD_ROOT + '/backup',
    StarFileSystem.SDCARD_ROOT + '/restore',
    StarFileSystem.SDCARD_ROOT + '/.backup',
    StarFileSystem.SDCARD_ROOT + '/titanium_backup',
    
    // 游戏存档
    StarFileSystem.SDCARD_ROOT + '/gameloft',
    StarFileSystem.SDCARD_ROOT + '/netease',
    StarFileSystem.SDCARD_ROOT + '/tencent/games',
    
    // 重要媒体目录
    StarFileSystem.SDCARD_ROOT + '/camera',
    StarFileSystem.SDCARD_ROOT + '/screenshots',
    StarFileSystem.SDCARD_ROOT + '/recordings',
  ];

  /// 常用垃圾清理规则 - 针对中国应用环境
  static List<RuleItem> getDefaultCleanRules() {
    return [
      // 临时文件和缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/temp',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '临时文件目录',
        priority: 10,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '缓存文件目录',
        priority: 10,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/.cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '隐藏缓存目录',
        priority: 10,
      ),
      
      // 浏览器缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/browser/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '浏览器缓存',
        priority: 8,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/uc/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: 'UC浏览器缓存',
        priority: 8,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/qq_browser/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: 'QQ浏览器缓存',
        priority: 8,
      ),
      
      // 社交应用缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/msflogs',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '微信日志文件',
        priority: 7,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/qq/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: 'QQ缓存文件',
        priority: 7,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/sina/weibo/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '新浪微博缓存',
        priority: 7,
      ),
      
      // 视频应用缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/youku/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '优酷视频缓存',
        priority: 6,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/iqiyi/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '爱奇艺视频缓存',
        priority: 6,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/video/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '腾讯视频缓存',
        priority: 6,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/douyin/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '抖音缓存文件',
        priority: 6,
      ),
      
      // 音乐应用缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/netease/cloudmusic/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '网易云音乐缓存',
        priority: 5,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/qqmusic/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: 'QQ音乐缓存',
        priority: 5,
      ),
      
      // 购物应用缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/taobao/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '淘宝缓存文件',
        priority: 5,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/jd/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '京东缓存文件',
        priority: 5,
      ),
      
      // 游戏缓存
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/tmgp/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '腾讯游戏缓存',
        priority: 4,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/netease/games/cache',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '网易游戏缓存',
        priority: 4,
      ),
      
      // 广告和统计文件
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/umeng',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '友盟统计数据',
        priority: 9,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/baidu/mobads',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '百度移动广告',
        priority: 9,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/beacon',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '腾讯灯塔统计',
        priority: 9,
      ),
      
      // 日志文件
      RuleItem(
        path: r'.*\.log$',
        pathMatchType: PathMatchType.regex,
        actionType: ActionType.delete,
        annotation: '各类日志文件',
        priority: 8,
      ),
      RuleItem(
        path: r'.*\.tmp$',
        pathMatchType: PathMatchType.regex,
        actionType: ActionType.delete,
        annotation: '临时文件',
        priority: 9,
      ),
      
      // 崩溃报告
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/crash',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '崩溃报告文件',
        priority: 8,
      ),
      RuleItem(
        path: StarFileSystem.SDCARD_ROOT + '/tombstones',
        pathMatchType: PathMatchType.prefix,
        actionType: ActionType.deleteAndReplace,
        annotation: '系统崩溃转储',
        priority: 8,
      ),
    ];
  }

  /// 默认路径标注 - 帮助用户理解各个目录的用途
  static List<PathAnnotation> getDefaultPathAnnotations() {
    return [
      // 系统目录标注
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/android',
        description: 'Android系统目录，包含应用数据和媒体文件',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/android/data',
        description: '应用私有数据目录，删除可能导致应用数据丢失',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/android/obb',
        description: '应用扩展包目录，删除可能导致游戏或应用无法正常运行',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      
      // 重要应用目录标注
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/tencent',
        description: '腾讯系应用目录，包含微信、QQ等重要数据',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/micromsg',
        description: '微信数据目录，包含聊天记录、图片等重要数据',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/dcim',
        description: '相机拍摄的照片和视频存储目录',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/pictures',
        description: '图片文件目录，可能包含重要照片',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/download',
        description: '下载文件目录，可能包含重要文档',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/documents',
        description: '文档目录，通常包含重要文件',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      
      // 可清理目录标注
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/temp',
        description: '临时文件目录，可以安全清理',
        suggestDelete: true,
        isBuiltIn: true,
        pathMatchType: PathMatchType.prefix,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/cache',
        description: '缓存文件目录，清理后可释放存储空间',
        suggestDelete: true,
        isBuiltIn: true,
        pathMatchType: PathMatchType.prefix,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/.cache',
        description: '隐藏缓存目录，可以安全清理',
        suggestDelete: true,
        isBuiltIn: true,
        pathMatchType: PathMatchType.prefix,
      ),
      
      // 特定应用缓存标注
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/tencent/msflogs',
        description: '微信日志文件，可以清理以释放空间',
        suggestDelete: true,
        isBuiltIn: true,
        pathMatchType: PathMatchType.prefix,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/umeng',
        description: '友盟统计数据，可以安全清理',
        suggestDelete: true,
        isBuiltIn: true,
        pathMatchType: PathMatchType.prefix,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/crash',
        description: '应用崩溃报告，可以清理',
        suggestDelete: true,
        isBuiltIn: true,
        pathMatchType: PathMatchType.prefix,
      ),
      
      // 游戏相关标注
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/gameloft',
        description: 'Gameloft游戏数据，删除会丢失游戏进度',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/netease',
        description: '网易游戏和应用数据目录',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      
      // 备份相关标注
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/backup',
        description: '备份文件目录，包含重要数据备份',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
      PathAnnotation(
        path: StarFileSystem.SDCARD_ROOT + '/titanium_backup',
        description: 'Titanium Backup备份数据，删除会丢失备份',
        suggestDelete: false,
        isBuiltIn: true,
        pathMatchType: PathMatchType.exact,
      ),
    ];
  }

  /// 获取扩展白名单项
  static List<Whitelist> getExtendedWhitelistItems() {
    return EXTENDED_WHITELIST_PATHS.map((path) => Whitelist(
      path: path,
      type: WhitelistType.path,
      annotation: '[内置规则]重要目录保护',
      readOnly: true,
    )).toList();
  }
}