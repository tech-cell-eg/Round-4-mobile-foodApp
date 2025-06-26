import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // Change from late final to nullable and private
  static SharedPreferences? _sharedPreferences;

  // Getter with null check
  static SharedPreferences get sharedPreferences {
    if (_sharedPreferences == null) {
      throw Exception(
        'SharedPreferences not initialized. Call CacheHelper.init() first',
      );
    }
    return _sharedPreferences!;
  }

  // Initialize only once
  static Future<void> init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      print('SharedPreferences initialized successfully');
    }
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    try {
      if (value is String) {
        return await sharedPreferences.setString(key, value);
      } else if (value is int) {
        return await sharedPreferences.setInt(key, value);
      } else if (value is bool) {
        return await sharedPreferences.setBool(key, value);
      } else if (value is double) {
        return await sharedPreferences.setDouble(key, value);
      }
      throw ArgumentError('Unsupported value type');
    } catch (e) {
      print('Error saving data for key $key: $e');
      return false;
    }
  }

  static dynamic getData({required String key}) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      print('Error getting data for key $key: $e');
      return null;
    }
  }

  static Future<bool> removeData({required String key}) async {
    try {
      return await sharedPreferences.remove(key);
    } catch (e) {
      print('Error removing data for key $key: $e');
      return false;
    }
  }

  // New method to clear all data
  static Future<bool> clearAll() async {
    try {
      return await sharedPreferences.clear();
    } catch (e) {
      print('Error clearing all data: $e');
      return false;
    }
  }
}
