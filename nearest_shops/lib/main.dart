import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/product/input_text_decoration.dart';
import 'core/base/route/generate_route.dart';
import 'core/init/service/cacheManager/CacheManager.dart';
import 'package:provider/provider.dart';

import 'core/constants/application_constants.dart';
import 'core/constants/navigation/navigation_service.dart';
import 'core/extension/string_extension.dart';
import 'core/init/lang/codegen_loader.g.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/lang/locale_keys.g.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/theme/app_theme.dart';
import 'view/onboard_initial/view/onboard_initial_view.dart';
import 'view/product/circular_progress/circular_progress_indicator.dart';

Future<void> main() async {
  await _init();
  await Hive.initFlutter();
  await CacheManager().getInstance();
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: EasyLocalization(
        path: ApplicationConstants.LANG_ASSET_PATH,
        supportedLocales: LanguageManager.instance.supportedLocales,
        fallbackLocale: LanguageManager.instance.enLocale,
        assetLoader: CodegenLoader(),
        saveLocale: true,
        startLocale: LanguageManager.instance.currentLocale,
        child: MainHome(),
      ),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // ICacheManager cacheManager = CacheManager();
  // String theme = await cacheManager.getThemeOption();
  // context!.read<ThemeManager>().changeTheme();
  //     currentAppThemeMode = context!.read<ThemeManager>().currentThemeMode;
  // theme.themeOptionString;
}

class MainHome extends StatelessWidget {
  final Future<FirebaseApp> _initalizeFirebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance!.navigatorKey,
      title: 'The Nearest',
      theme: context.watch<ThemeManager>().currentThemeData,
      home: FutureBuilder(
        future: _initalizeFirebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(LocaleKeys.thereIsAnErrorOnBeginnigText.locale, style: titleTextStyle(context)),
            );
          } else if (snapshot.hasData) {
            return SafeArea(child: OnBoardInitialView());
          } else {
            return CallCircularProgress(context);
          }
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
