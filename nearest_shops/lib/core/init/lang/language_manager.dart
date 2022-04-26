import 'dart:io';

import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = Locale('en');
  final trLocale = Locale('tr');

  Locale get currentLocale =>Platform.localeName.contains("tr")?trLocale:enLocale;

  List<Locale> get supportedLocales => [enLocale, trLocale];

  String getLanguageTitle(Locale locale) {
    if (locale == trLocale) {
      return "Türkçe";
    }
    return "English";
  }
}
