import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/util/shared_prefs_util.dart';

const int _defaultStyleNumber = 0;

class Styles {
  static const Color unfurnishedIconColor = Colors.redAccent;
  static const Color furnishedIconColor = Colors.lightGreen;

  static List<CustomTheme> _themeList = [
    CustomTheme(
      primaryColor: Color(0xff8bb8e1),
      primaryColorDark: Color(0xff305f95),
      accentColor: Colors.indigo,
    ),
    CustomTheme(
      primaryColor: Color(0xff9ae4f1),
      primaryColorDark: Color(0xff3e7482),
      accentColor: Colors.teal,
      unselectedTabItemColor: Colors.teal,
    ),
    CustomTheme(
      primaryColor: Color(0xffaa7398),
      primaryColorDark: Color(0xff602d5f),
      accentColor: Colors.deepPurple,
    ),
    CustomTheme(
      primaryColor: Color(0xffdc8875),
      primaryColorDark: Color(0xffb5304c),
      accentColor: Color(0xffb5304c),
    ),
    CustomTheme(
      primaryColor: Color(0xfffa9dbe),
      primaryColorDark: Color(0xffef878d),
      accentColor: Colors.pink,
      unselectedTabItemColor: Colors.pink,
    ),
    CustomTheme(
      primaryColor: Color(0xff7f7f7f),
      primaryColorDark: Color(0xffa5cad2),
      accentColor: Color(0xff7f7f7f),
    ),
    CustomTheme(
      primaryColor: Color(0xffcb715d),
      primaryColorDark: Color(0xffe5a15a),
      accentColor: Color(0xffcb715d),
    ),
    CustomTheme(
      primaryColor: Color(0xfffef7f2),
      primaryColorDark: Color(0xffffe4d9),
      colorOnPrimary: Color(0xffef8270),
      accentColor: Color(0xffef8270),
      unselectedTabItemColor: Color(0xffef8270),
    ),
    CustomTheme(
      primaryColor: Color(0xff94daec),
      primaryColorDark: Color(0xffb8ecdf),
      unselectedTabItemColor: Colors.indigoAccent,
    ),
    CustomTheme(
      primaryColor: Color(0xff94ecde),
      primaryColorDark: Color(0xff06c0da),
      accentColor: Colors.teal,
      unselectedTabItemColor: Colors.teal,
    ),
    CustomTheme(
      primaryColor: Color(0xffe7f1fd),
      primaryColorDark: Color(0xffc3cad0),
      colorOnPrimary: Color(0xff615cbf),
      unselectedTabItemColor: Color(0x7f615cbf),
    ),
    CustomTheme(
      primaryColor: Color(0xff615cbf),
      primaryColorDark: Color(0xff1c2f4b),
    ),
    CustomTheme(
      primaryColor: Color(0xff687791),
      primaryColorDark: Color(0xff1c2f4b),
    ),
    CustomTheme(
      primaryColor: Color(0xffffd96f),
      primaryColorDark: Color(0xffd89a23),
      colorOnPrimary: Colors.redAccent,
      accentColor: Colors.redAccent.withAlpha(200),
      unselectedTabItemColor: Colors.redAccent.withAlpha(200),
    ),
    CustomTheme(
      primaryColor: Color(0xffb4c656),
      primaryColorDark: Color(0xff53783b),
      accentColor: Color(0xff378566),
      unselectedTabItemColor: Color(0xff378566),
    ),
    CustomTheme(
      primaryColor: Color(0xffddc4e0),
      primaryColorDark: Color(0xff90a6ab),
      accentColor: Color(0xff61359a),
    ),
    CustomTheme(
      primaryColor: Color(0xffdde3f0),
      primaryColorDark: Color(0xffb5bccc),
      unselectedTabItemColor: Colors.indigo,
    ),
    CustomTheme(
      primaryColor: Color(0xffffc7bb),
      primaryColorDark: Color(0xffef8270),
      accentColor: Color(0xffef8270),
      unselectedTabItemColor: Color(0xffef8270),
    ),
    CustomTheme(
      primaryColor: Color(0xffc8e6c9),
      primaryColorDark: Color(0xff378566),
      accentColor: Color(0xff006667),
      unselectedTabItemColor: Color(0xff006667),
    ),
    CustomTheme(
      primaryColor: Color(0xff006667),
      primaryColorDark: Color(0xff0a1e11),
      accentColor: Color(0xff006667),
    ),
    CustomTheme(
      primaryColor: Color(0xff61359a),
      primaryColorDark: Color(0xff19094a),
      accentColor: Colors.purple,
    ),
    CustomTheme(
      primaryColor: Color(0xffe01094),
      primaryColorDark: Color(0xff2f054e),
      accentColor: Colors.deepPurple,
    ),
    CustomTheme(
      primaryColor: Color(0xff3578b1),
      primaryColorDark: Color(0xff0e2453),
    ),
  ];

  static int _currentStyleNumber;

  static int get currentStyleNumber => _currentStyleNumber;

  static get numStyles => _themeList.length;

  static Future init() async {
    await SharedPrefsUtil.instance.init();
    _currentStyleNumber =
        SharedPrefsUtil.instance.getChosenStyle() ?? _defaultStyleNumber;
  }

  static Color getPrimaryColor({int styleNumber}) {
    try {
      int index = styleNumber ?? SharedPrefsUtil.instance.getChosenStyle();
      return _themeList[index].primaryColor;
    } catch (e) {
      return _themeList[_defaultStyleNumber].primaryColor;
    }
  }

  static Color getPrimaryColorDark({int styleNumber}) {
    try {
      int index = styleNumber ?? SharedPrefsUtil.instance.getChosenStyle();
      return _themeList[index].primaryColorDark;
    } catch (e) {
      return _themeList[_defaultStyleNumber].primaryColorDark;
    }
  }

  static Color getAccentColor({int styleNumber}) {
    try {
      int index = styleNumber ?? SharedPrefsUtil.instance.getChosenStyle();
      return _themeList[index].accentColor;
    } catch (e) {
      return _themeList[_defaultStyleNumber].accentColor;
    }
  }

  static Color getColorOnPrimary({int styleNumber}) {
    try {
      int index = styleNumber ?? SharedPrefsUtil.instance.getChosenStyle();
      return _themeList[index].colorOnPrimary;
    } catch (e) {
      return _themeList[_defaultStyleNumber].colorOnPrimary;
    }
  }

  static Color getTabBarUnselectedItemColor({int styleNumber}) {
    try {
      int index = styleNumber ?? SharedPrefsUtil.instance.getChosenStyle();
      CustomTheme theme = _themeList[index];
      return theme.unselectedTabItemColor ?? theme.accentColor;
    } catch (e) {
      CustomTheme theme = _themeList[_defaultStyleNumber];
      return theme.unselectedTabItemColor ?? theme.accentColor;
    }
  }

  static Gradient getBackgroundGradient({int styleNumber}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.1, 0.9],
      colors: [
        getPrimaryColor(styleNumber: styleNumber),
        getPrimaryColorDark(styleNumber: styleNumber),
      ],
    );
  }
}

class CustomTheme {
  final Color primaryColor;
  final Color primaryColorDark;
  final Color accentColor;
  final Color colorOnPrimary;
  final Color unselectedTabItemColor;

  CustomTheme({
    @required this.primaryColor,
    @required this.primaryColorDark,
    this.accentColor = Colors.indigo,
    this.colorOnPrimary = Colors.white,
    this.unselectedTabItemColor = Colors.white70,
  });
}
