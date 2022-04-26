import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nearest_shops/view/onboard/builder_Ex.dart';
import 'package:nearest_shops/view/onboard/onboard_view.dart';
import 'package:provider/provider.dart';

import 'core/constants/application_constants.dart';
import 'core/constants/navigation/navigation_service.dart';
import 'core/extension/string_extension.dart';
import 'core/init/lang/codegen_loader.g.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/lang/locale_keys.g.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/theme/app_theme.dart';
import 'view/authentication/onboard/view/onboard_view.dart';

Future<void> main() async {
  await _init();

  await dotenv.load(fileName: '.env');
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

      //onGenerateRoute: NavigationRoute.instance!.generateRoute,
      navigatorKey: NavigationService.instance!.navigatorKey,
      title: 'Material App',
      theme: context.watch<ThemeManager>().currentThemeData,
      home: FutureBuilder(
        future: _initalizeFirebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(LocaleKeys.thereIsAnErrorOnBeginnigText.locale),
            );
          } else if (snapshot.hasData) {
            return SafeArea(child: OnBoardViewLottie());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
