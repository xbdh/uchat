import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_sources.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> setString(String key, String value) async {
    return await sharedPreferences.setString(key, value);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await sharedPreferences.setBool(key, value);
  }

  @override
  Future<bool> setList(String key, List<String> value) async {
    return await sharedPreferences.setStringList(key, value);
  }

  @override
  String getString(String key) {
    return sharedPreferences.getString(key) ?? '';
  }

  @override
  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  @override
  List<String> getList(String key) {
    return sharedPreferences.getStringList(key) ?? [];
  }

  @override
  Future<bool> remove(String key) async {
    return await sharedPreferences.remove(key);
  }

}