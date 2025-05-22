import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

abstract class HistoryDao {
  static Future<List<History>> getAll() async {
    return await DatabaseManager.database.getAllHistories();
  }

  static Future<void> add(History history) async {
    await DatabaseManager.database.addHistory(history);
  }
}
