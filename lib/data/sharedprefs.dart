import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  bool checkKey(String key) {
    return _prefsInstance.containsKey(key);
  }

  Future putString(String key, String value) {
    return _prefsInstance.setString(key, value);
  }

  Future putInt(String key, int value) {
    return _prefsInstance.setInt(key, value);
  }

  Future putBool(String key, bool value) {
    return _prefsInstance.setBool(key, value);
  }

  Future putStringList(String key, List<String> value) {
    return _prefsInstance.setStringList(key, value);
  }

  Future removeKey(String key) async {
    _prefsInstance.remove(key);
  }

  Future clearAll() async {
    for (String key in _prefsInstance.getKeys()) {
      if (key != 'isFirstTime' &&
          key != 'fcm' &&
          key != 'username' &&
          key != 'password' &&
          key != 'biometric') {
        _prefsInstance.remove(key);
      }
    }
  }

  String? getString(String key) {
    return _prefsInstance.getString(key);
  }

  int? getInt(String key) {
    return _prefsInstance.getInt(key);
  }

  bool? getBool(String key) {
    return _prefsInstance.getBool(key);
  }

  List? getStringList(String key) {
    return _prefsInstance.getStringList(key);
  }
}
