// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OwnerProfileViewModel on _OwnerProfileViewModelBase, Store {
  final _$userAtom = Atom(name: '_OwnerProfileViewModelBase.user');

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
      Atom(name: '_OwnerProfileViewModelBase.profileLoading');

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
      Atom(name: '_OwnerProfileViewModelBase.isImageSelected');

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

  final _$pickedFileAtom = Atom(name: '_OwnerProfileViewModelBase.pickedFile');

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

  final _$_imageUrlAtom = Atom(name: '_OwnerProfileViewModelBase._imageUrl');

  @override
  String? get _imageUrl {
    _$_imageUrlAtom.reportRead();
    return super._imageUrl;
  }

  @override
  set _imageUrl(String? value) {
    _$_imageUrlAtom.reportWrite(value, super._imageUrl, () {
      super._imageUrl = value;
    });
  }

  final _$isUpdatingAtom = Atom(name: '_OwnerProfileViewModelBase.isUpdating');

  @override
  bool get isUpdating {
    _$isUpdatingAtom.reportRead();
    return super.isUpdating;
  }

  @override
  set isUpdating(bool value) {
    _$isUpdatingAtom.reportWrite(value, super.isUpdating, () {
      super.isUpdating = value;
    });
  }

  final _$selectImageAsyncAction =
      AsyncAction('_OwnerProfileViewModelBase.selectImage');

  @override
  Future<void> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$_OwnerProfileViewModelBaseActionController =
      ActionController(name: '_OwnerProfileViewModelBase');

  @override
  void changeIsUpdating() {
    final _$actionInfo = _$_OwnerProfileViewModelBaseActionController
        .startAction(name: '_OwnerProfileViewModelBase.changeIsUpdating');
    try {
      return super.changeIsUpdating();
    } finally {
      _$_OwnerProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isImageSelectedChange() {
    final _$actionInfo = _$_OwnerProfileViewModelBaseActionController
        .startAction(name: '_OwnerProfileViewModelBase.isImageSelectedChange');
    try {
      return super.isImageSelectedChange();
    } finally {
      _$_OwnerProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeProfileLoading() {
    final _$actionInfo = _$_OwnerProfileViewModelBaseActionController
        .startAction(name: '_OwnerProfileViewModelBase.changeProfileLoading');
    try {
      return super.changeProfileLoading();
    } finally {
      _$_OwnerProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
profileLoading: ${profileLoading},
isImageSelected: ${isImageSelected},
pickedFile: ${pickedFile},
isUpdating: ${isUpdating}
    ''';
  }
}
