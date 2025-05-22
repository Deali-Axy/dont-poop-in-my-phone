import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

class HistoryDao {
  static Future<List<models.History>> getAll() async {
    return await DatabaseManager.service.getAllHistories();
  }

  static Future<models.History> add(models.History history) async {
    return await DatabaseManager.service.addHistory(history);
  }

  static Future<void> deleteHistory(int historyId) async {
    print("HistoryDao.deleteHistory not implemented yet in service.");
    // TODO: Implement in DatabaseService: await DatabaseManager.service.deleteHistory(historyId);
  }

  static Future<void> clearAllHistory() async {
    await DatabaseManager.service.clearAllHistory();
  }
}
