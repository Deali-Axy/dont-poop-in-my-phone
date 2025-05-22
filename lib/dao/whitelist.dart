import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

abstract class WhitelistDao {
  static Future<List<Whitelist>> getAll() async {
    return await DatabaseManager.database.getAllWhitelists();
  }

  static Future<bool> contains(String path) async {
    return await DatabaseManager.database.whitelistContains(path);
  }

  static Future<Whitelist?> add(Whitelist whitelist) async {
    return await DatabaseManager.database.addWhitelist(whitelist);
  }

  static Future<Whitelist?> addPath(String path, {String annotation = ''}) async {
    var item = Whitelist(path: path.toLowerCase(), annotation: annotation);
    return await add(item);
  }

  static Future<void> delete(String path) async {
    await DatabaseManager.database.deleteWhitelist(path);
  }
}
