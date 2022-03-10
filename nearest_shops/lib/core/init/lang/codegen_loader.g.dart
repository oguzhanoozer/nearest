// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "hello": "Welcome to My App",
  "shoplistTitle": "Shops",
  "login": "Login",
  "email": "Email",
  "loginButtonText": "Login",
  "password": "Password",
  "enterPassword": "Enter password",
  "againPassword": "Enter again password",
  "welcomeBack": "Welcome Back",
  "createAccount": "Create Account",
  "forgotPassword": "Forgot Password",
  "theFieldRequired": "This field required.",
  "enterValidEmail": "Enter a valid email."
};
static const Map<String,dynamic> tr = {
  "hello": "Merhaba",
  "shoplistTitle": "Mağazalar",
  "login": "Giriş",
  "email": "Email",
  "loginButtonText": "Giriş Yap",
  "password": "Şifre",
  "enterPassword": "Şifre giriniz",
  "againPassword": "Şifreyi yeniden giriniz",
  "welcomeBack": "Tekrar Hoşgeldiniz",
  "createAccount": "Hesap Oluştur",
  "forgotPassword": "Şifremi unuttum",
  "theFieldRequired": "Bu alanın doldurulması gerekiyor.",
  "enterValidEmail": "Geçerli bir email adresi giriniz."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "tr": tr};
}
