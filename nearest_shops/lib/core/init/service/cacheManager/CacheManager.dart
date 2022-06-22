import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../lang/language_manager.dart';
import '../../theme/app_theme.dart';

abstract class ICacheManager {
  Box? _cacheBox;
  ICacheManager() {
    init();
  }

  Future<void> init() async {
    if (!(_cacheBox?.isOpen ?? false)) {
      _cacheBox = await Hive.openBox("cache_db");
    }
  }

  String getItems();
  Future<void> putItems(String item);

  String getThemeOption();
  Future<void> putThemeOption(String item);
}

class CacheManager {
  static CacheManager? _instance;

  Future<CacheManager> getInstance() async {
    if (_instance == null) {
      _instance = CacheManager();
      await _instance!.init();
    }
    return _instance!;
  }

  static CacheManager get instance => _instance!;

  late Box _cacheBox;

  CacheManager();

  Future<CacheManager> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    _cacheBox = await Hive.openBox('location');
    return this;
  }

  Future<void> putInitialApk(String item) async {
    await _cacheBox.put(CacheManagerEnum.InitialApk.toString(), item);
  }

  String getInitialApk() {
    return _cacheBox.get(CacheManagerEnum.InitialApk.toString()) ?? "0";
  }

  String getThemeOption() {
    String? currentThemeData = _cacheBox.get(CacheManagerEnum.ThemeOption.toString());
    return currentThemeData ?? AppThemeMode.ThemeLight.themeOption;
  }

  Future<void> putThemeOption(String themeTitle) async {
    await _cacheBox.put(CacheManagerEnum.ThemeOption.toString(), themeTitle);
  }

  Future<void> putLangOption(String langTitle) async {
    await _cacheBox.put(CacheManagerEnum.LangOption.toString(), langTitle);
  }

  String getLangOption() {
    String? currentLangData = _cacheBox.get(CacheManagerEnum.LangOption.toString());
    return currentLangData ?? langOption.en.getLangOption;

    ///(Platform.localeName.contains(langOption.tr.getLangOption) ? langOption.tr.getLangOption :langOption.en.getLangOption);
  }
}

enum CacheManagerEnum { InitialApk, ThemeOption, LangOption }
