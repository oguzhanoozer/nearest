import 'package:flutter/material.dart';

import '../service/cacheManager/CacheManager.dart';
import 'color/color_manager.dart';
import 'color/dark_color.dart';
import 'color/light_color.dart';
import 'text/dark_text.dart';
import 'text/light_text.dart';
import 'text/text_theme_manager.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColors get colors;
}

enum AppThemeMode { ThemeDark, ThemeLight }

extension ThemeOptionStringExtension on String {
  AppThemeMode get themeOptionString {
    switch (this) {
      case "lightTheme":
        return AppThemeMode.ThemeLight;
      case "darkTheme":
        return AppThemeMode.ThemeDark;
    }
    throw "ThemeData not found";
  }
}

extension ThemeOptionExtension on AppThemeMode {
  String get themeOption {
    switch (this) {
      case AppThemeMode.ThemeLight:
        return "lightTheme";
      case AppThemeMode.ThemeDark:
        return "darkTheme";
    }
  }
}

class ThemeManager extends ChangeNotifier {
  ThemeManager() {
    initialTheme();
  }

  AppThemeMode? _currentThemeMode;
  AppThemeMode get currentThemeMode => _currentThemeMode!;

  ThemeData? _currentThemeData;
  ThemeData get currentThemeData => _currentThemeData!;

  void changeTheme() async {
    if (_currentThemeMode == AppThemeMode.ThemeDark) {
      _currentThemeMode = AppThemeMode.ThemeLight;
      _currentThemeData = createTheme(AppThemeLight());
    } else {
      _currentThemeMode = AppThemeMode.ThemeDark;
      _currentThemeData = createTheme(AppThemeDark());
    }
    await CacheManager.instance.putThemeOption(_currentThemeMode!.themeOption);

    notifyListeners();
  }

  void initialTheme() {
    String savedThemeOption = CacheManager.instance.getThemeOption();
    _currentThemeMode = savedThemeOption.themeOptionString;
    _currentThemeData = createTheme(_currentThemeMode == AppThemeMode.ThemeDark ? AppThemeDark() : AppThemeLight());
  }

  static ThemeData createTheme(ITheme theme) => ThemeData(
        fontFamily: theme.textTheme.fontFamily,
        textTheme: theme.textTheme.data,
        colorScheme: theme.colors.colorScheme,
        scaffoldBackgroundColor: theme.colors.scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: theme.colors.appBarColor, elevation: 0),


      );
}

InputDecorationTheme buildInputDecorationTheme(ITheme theme) {
  return InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: theme.colors.colors.green),
    focusColor: Colors.black12,
    filled: true,
    errorStyle: TextStyle(color: theme.colors.colors.green),
    fillColor: theme.colors.colorScheme!.onSecondary,
 
  );
}

class AppThemeDark extends ITheme {
  @override
  IColors get colors => DarkColors();

  @override
  ITextTheme get textTheme => TextThemeDark(colors.colors.mediumGrey);
}

class AppThemeLight extends ITheme {
  @override
  IColors get colors => LightColors();

  @override
  ITextTheme get textTheme => TextThemeLight(colors.colors.darkerGrey);
}
