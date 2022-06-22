import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/service/cacheManager/CacheManager.dart';
import '../../../../core/init/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:kartal/kartal.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../authentication/onboard/view/onboard_view.dart';
import '../service/IUserProfile_service.dart';
part 'user_profile_view_model.g.dart';

class UserProfileViewModel = _UserProfileViewModelBase with _$UserProfileViewModel;

abstract class _UserProfileViewModelBase with Store, BaseViewModel {
  final GlobalKey<FormState> formState = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? emailController;

  late IUserProfileService _userProfileService;

  @observable
  bool isLogOut = false;

  @action
  void changeIsLogOut() {
    isLogOut = !isLogOut;
  }

  @observable
  User? user;

  @observable
  bool profileLoading = false;

  @observable
  bool isImageSelected = false;

  final ImagePicker picker = ImagePicker();

  @observable
  XFile? pickedFile;

  late AppThemeMode currentAppThemeMode;

  late Locale appLocale;
  late String currentLangTitle;

  @override
  init() async {
    changeProfileLoading();
    emailController = TextEditingController();
    user = FirebaseAuthentication.instance.authCurrentUser();
    emailController!.text = user!.email!;
    changeProfileLoading();
  }

  @override
  setContext(BuildContext context) {
    this.context = context;
    _userProfileService = UserProfileService(scaffoldState, context);

    currentAppThemeMode = context.read<ThemeManager>().currentThemeMode;
    changerLangSetting(context.locale);
  }

  Future<void> logOut() async {
    changeIsLogOut();
    await FirebaseAuthentication.instance.signOut();
    Navigator.pushReplacementNamed(context!, onBoardViewRoute);
    changeIsLogOut();
  }

  void changerLangSetting(Locale locale) {
    appLocale = locale;
    currentLangTitle = LanguageManager.instance.getLanguageTitle(appLocale);
  }

  String? photoImageUrl() {
    if (user != null) {
      if (user!.photoURL != null && user!.photoURL!.isNotEmpty) {
        return user!.photoURL;
      }
    }
    return null;
  }

  @action
  void changeAppLanguage(Locale? locale) {
    if (locale != null) {
      appLocale = locale;
      changerLangSetting(appLocale);
      context!.setLocale(locale);
    }
  }

  Future<void> updateEmailAddress() async {
    await _userProfileService.updateEmailAddress(emailController!.text);
  }

  @action
  Future<void> selectImage() async {
    isImageSelectedChange();

    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? url = await _userProfileService.uploadProfileImage(File(pickedFile!.path));
    }

    isImageSelectedChange();
  }

  Future<void> changeAppTheme() async {
    if (this.context != null) {
      context!.read<ThemeManager>().changeTheme();
      currentAppThemeMode = context!.read<ThemeManager>().currentThemeMode;
    }
  }

  Future<void> deleteAccount() async {
    await _userProfileService.deleteAccount();

    Navigator.pushReplacementNamed(context!, onBoardViewRoute);
  }

  @action
  void isImageSelectedChange() {
    isImageSelected = !isImageSelected;
  }

  @action
  void changeProfileLoading() {
    profileLoading = !profileLoading;
  }
}
