import 'dart:convert';
import 'package:loja/domain/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ISharedPreferencesService {
  @override
  Future<void> saveData<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      final jsonString = jsonEncode(value);
      await prefs.setString(key, jsonString);
    } else {
      throw UnsupportedError('Tipo não suportado: ${T.toString()}');
    }
  }

  @override
  Future<T?> getData<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else if (T == Map<String, dynamic>) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        return jsonDecode(jsonString) as T;
      }
      return null;
    } else {
      throw UnsupportedError('Tipo não suportado: ${T.toString()}');
    }
  }

  @override
  Future<void> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
