import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  Future readCache(String emailGoogle) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? cache = _preferences.getString('emailGoogle');
    return cache;
  }

  Future historyCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? cache = _preferences.getString('selectedRandomId');
    return cache;
  }

  Future removeCache(String emailGoogle) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('emailGoogle');
  }
}