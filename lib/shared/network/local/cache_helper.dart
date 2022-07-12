import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/shared/components/components.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setString(key, value);
  }

  static dynamic getData(String key) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> deleteCachedData({
    context,
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
