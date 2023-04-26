import 'package:afisha_market/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static SharedPreferences? _preferences;

  LocalStorage._();

  static LocalStorage? _localStorage;

  static LocalStorage instance = LocalStorage._();

  static Future<LocalStorage> getInstance()async{
    if(_localStorage == null){
      _localStorage = LocalStorage._();
      await _localStorage?._init();
    }
    return _localStorage!;
  }

  Future<void> _init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String? token) async {
    if (_preferences != null) {
      await _preferences!.setString(AppConstants.keyToken, token ?? '');
    }
  }

  String getToken() => _preferences?.getString(AppConstants.keyToken) ?? '';

  void deleteToken() => _preferences?.remove(AppConstants.keyToken);
}