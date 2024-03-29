import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';

abstract class WhitelistDao {
  static List<Whitelist> getAll() {
    return Global.appConfig.whiteList;
  }

  static bool contains(String path) {
    var result = false;
    var list = getAll();
    for (var item in list) {
      if (item.path == path.toLowerCase()) {
        result = true;
      }
    }

    return result;
  }

  static Whitelist? add(Whitelist whitelist) {
    if (contains(whitelist.path)) {
      return null;
    }
    Global.appConfig.whiteList.add(whitelist);
    Global.saveAppConfig();

    return whitelist;
  }

  static Whitelist? addPath(String path, {String annotation = ''}) {
    var item = Whitelist(path: path.toLowerCase(), annotation: annotation); 
    return add(item);
  }

  static void delete(String path) {
    Global.appConfig.whiteList.removeWhere((e) => e.path == path);
    Global.saveAppConfig();
  }
}
