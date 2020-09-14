import 'package:shared_preferences/shared_preferences.dart';

const String _styleKey = 'style';

class SharedPrefsUtil {
  SharedPreferences _prefs;

  static final SharedPrefsUtil _instance =
      SharedPrefsUtil._privateConstructor();

  static SharedPrefsUtil get instance => _instance;

  SharedPrefsUtil._privateConstructor();

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int getChosenStyle() {
    return _prefs.getInt(_styleKey);
  }

  void saveChosenStyle(int styleNumber) async {
    await _prefs.setInt(_styleKey, styleNumber);
  }
}
