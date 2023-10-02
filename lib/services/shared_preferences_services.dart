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

  Future themeCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? cache = _preferences.getString('darkLight');
    return cache;
  }

  Future removeCache(String emailGoogle) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('emailGoogle');
  }

  Future removeHistory(String selectedRandomId) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('selectedRandomId');
  }
}
