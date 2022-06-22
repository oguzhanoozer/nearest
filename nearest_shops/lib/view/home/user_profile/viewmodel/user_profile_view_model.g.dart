// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileViewModel on _UserProfileViewModelBase, Store {
  final _$isLogOutAtom = Atom(name: '_UserProfileViewModelBase.isLogOut');

  @override
  bool get isLogOut {
    _$isLogOutAtom.reportRead();
    return super.isLogOut;
  }

  @override
  set isLogOut(bool value) {
    _$isLogOutAtom.reportWrite(value, super.isLogOut, () {
      super.isLogOut = value;
    });
  }

  final _$userAtom = Atom(name: '_UserProfileViewModelBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$profileLoadingAtom =
      Atom(name: '_UserProfileViewModelBase.profileLoading');

  @override
  bool get profileLoading {
    _$profileLoadingAtom.reportRead();
    return super.profileLoading;
  }

  @override
  set profileLoading(bool value) {
    _$profileLoadingAtom.reportWrite(value, super.profileLoading, () {
      super.profileLoading = value;
    });
  }

  final _$isImageSelectedAtom =
      Atom(name: '_UserProfileViewModelBase.isImageSelected');

  @override
  bool get isImageSelected {
    _$isImageSelectedAtom.reportRead();
    return super.isImageSelected;
  }

  @override
  set isImageSelected(bool value) {
    _$isImageSelectedAtom.reportWrite(value, super.isImageSelected, () {
      super.isImageSelected = value;
    });
  }

  final _$pickedFileAtom = Atom(name: '_UserProfileViewModelBase.pickedFile');

  @override
  XFile? get pickedFile {
    _$pickedFileAtom.reportRead();
    return super.pickedFile;
  }

  @override
  set pickedFile(XFile? value) {
    _$pickedFileAtom.reportWrite(value, super.pickedFile, () {
      super.pickedFile = value;
    });
  }

  final _$selectImageAsyncAction =
      AsyncAction('_UserProfileViewModelBase.selectImage');

  @override
  Future<void> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$_UserProfileViewModelBaseActionController =
      ActionController(name: '_UserProfileViewModelBase');

  @override
  void changeIsLogOut() {
    final _$actionInfo = _$_UserProfileViewModelBaseActionController
        .startAction(name: '_UserProfileViewModelBase.changeIsLogOut');
    try {
      return super.changeIsLogOut();
    } finally {
      _$_UserProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeAppLanguage(Locale? locale) {
    final _$actionInfo = _$_UserProfileViewModelBaseActionController
        .startAction(name: '_UserProfileViewModelBase.changeAppLanguage');
    try {
      return super.changeAppLanguage(locale);
    } finally {
      _$_UserProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isImageSelectedChange() {
    final _$actionInfo = _$_UserProfileViewModelBaseActionController
        .startAction(name: '_UserProfileViewModelBase.isImageSelectedChange');
    try {
      return super.isImageSelectedChange();
    } finally {
      _$_UserProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeProfileLoading() {
    final _$actionInfo = _$_UserProfileViewModelBaseActionController
        .startAction(name: '_UserProfileViewModelBase.changeProfileLoading');
    try {
      return super.changeProfileLoading();
    } finally {
      _$_UserProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogOut: ${isLogOut},
user: ${user},
profileLoading: ${profileLoading},
isImageSelected: ${isImageSelected},
pickedFile: ${pickedFile}
    ''';
  }
}
