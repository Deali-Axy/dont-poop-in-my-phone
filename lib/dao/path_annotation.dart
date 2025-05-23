import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

class PathAnnotationDao {
  static Future<List<models.PathAnnotation>> getAll() async {
    return await DatabaseManager.service.getAllPathAnnotations();
  }
  
  static Future<models.PathAnnotation?> getByPath(String path) async {
    return await DatabaseManager.service.getPathAnnotationByPath(path);
  }
  
  static Future<models.PathAnnotation?> add(models.PathAnnotation annotation) async {
    return await DatabaseManager.service.addPathAnnotation(annotation);
  }
  
  static Future<models.PathAnnotation?> update(models.PathAnnotation annotation) async {
    return await DatabaseManager.service.updatePathAnnotation(annotation);
  }
  
  static Future<void> delete(int id) async {
    await DatabaseManager.service.deletePathAnnotation(id);
  }
} 