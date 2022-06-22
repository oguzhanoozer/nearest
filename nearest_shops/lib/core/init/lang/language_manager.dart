import 'package:flutter/material.dart';

import '../service/cacheManager/CacheManager.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = Locale('en');
  final trLocale = Locale('tr');

  Locale get currentLocale => CacheManager.instance.getLangOption().langOptionString;

  List<Locale> get supportedLocales => [enLocale, trLocale];

  String getLanguageTitle(Locale locale) {
    if (locale == trLocale) {
      return "Türkçe";
    }
    return "English";
  }

}

extension LangOptionStringExtension on String {
  Locale get langOptionString {
    switch (this) {
      case "en":
        return LanguageManager.instance.enLocale;
      case "tr":
        return LanguageManager.instance.trLocale;
    }
    throw "Language Data not found";
  }
}

enum langOption { tr, en }

extension langOptionExtension on langOption {
  String get getLangOption {
    switch (this) {
      case langOption.en:
        return "en";
      case langOption.tr:
        return "tr";      
    }
    
  }
}
