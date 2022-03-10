import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/view/home/owner_product_list/view/owner_product_list_view.dart';
import 'package:provider/provider.dart';

import 'core/constants/application_constants.dart';
import 'core/constants/navigation/navigation_service.dart';
import 'core/init/lang/codegen_loader.g.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/theme/app_theme.dart';
import 'view/authentication/onboard/view/onboard_view.dart';

Future<void> main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: EasyLocalization(
        path: ApplicationConstants.LANG_ASSET_PATH,
        supportedLocales: LanguageManager.instance.supportedLocales,
        fallbackLocale: LanguageManager.instance.trLocale,
        assetLoader: const CodegenLoader(),
        saveLocale: true,
        startLocale: LanguageManager.instance.trLocale,
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
      theme: ThemeManager.createTheme(AppThemeLight()),
      home: FutureBuilder(
        future: _initalizeFirebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("There is an error"),
            );
          } else if (snapshot.hasData) {
            return SafeArea(child: OwnerProductListView());
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
