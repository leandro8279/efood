import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService({required SharedPreferences sharedPreferences}) : _prefs = sharedPreferences;

  final SharedPreferences _prefs;

  bool contains(String key) => _prefs.containsKey(key);

  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  Future<bool> clear() => _prefs.clear();
}
