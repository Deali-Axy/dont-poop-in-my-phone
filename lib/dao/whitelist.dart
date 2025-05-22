import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

class WhitelistDao {
  static Future<List<models.Whitelist>> getAll() async {
    return await DatabaseManager.service.getAllWhitelists();
  }

  static Future<bool> containsPath(String path) async {
    return await DatabaseManager.service.whitelistContains(path);
  }

  static Future<models.Whitelist?> add(models.Whitelist whitelist) async {
    return await DatabaseManager.service.addWhitelist(whitelist);
  }

  static Future<models.Whitelist?> addPath(String path, {models.WhitelistType type = models.WhitelistType.path, String annotation = ''}) async {
    var item = models.Whitelist(path: path.toLowerCase(), type: type, annotation: annotation);
    return await add(item);
  }

  static Future<void> deleteByPath(String path) async {
    await DatabaseManager.service.deleteWhitelist(path);
  }
}
