// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_owner_settings_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShopOwnerSettingsViewModel on _ShopOwnerSettingsViewModelBase, Store {
  final _$isLogOutAtom = Atom(name: '_ShopOwnerSettingsViewModelBase.isLogOut');

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

  final _$_ShopOwnerSettingsViewModelBaseActionController =
      ActionController(name: '_ShopOwnerSettingsViewModelBase');

  @override
  void changeIsLogOut() {
    final _$actionInfo = _$_ShopOwnerSettingsViewModelBaseActionController
        .startAction(name: '_ShopOwnerSettingsViewModelBase.changeIsLogOut');
    try {
      return super.changeIsLogOut();
    } finally {
      _$_ShopOwnerSettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeAppLanguage(Locale? locale) {
    final _$actionInfo = _$_ShopOwnerSettingsViewModelBaseActionController
        .startAction(name: '_ShopOwnerSettingsViewModelBase.changeAppLanguage');
    try {
      return super.changeAppLanguage(locale);
    } finally {
      _$_ShopOwnerSettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogOut: ${isLogOut}
    ''';
  }
}
