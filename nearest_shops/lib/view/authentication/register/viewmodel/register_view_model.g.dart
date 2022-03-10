// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterViewModel on _RegisterViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_RegisterViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isFirstLockOpenAtom =
      Atom(name: '_RegisterViewModelBase.isFirstLockOpen');

  @override
  bool get isFirstLockOpen {
    _$isFirstLockOpenAtom.reportRead();
    return super.isFirstLockOpen;
  }

  @override
  set isFirstLockOpen(bool value) {
    _$isFirstLockOpenAtom.reportWrite(value, super.isFirstLockOpen, () {
      super.isFirstLockOpen = value;
    });
  }

  final _$isLaterLockOpenAtom =
      Atom(name: '_RegisterViewModelBase.isLaterLockOpen');

  @override
  bool get isLaterLockOpen {
    _$isLaterLockOpenAtom.reportRead();
    return super.isLaterLockOpen;
  }

  @override
  set isLaterLockOpen(bool value) {
    _$isLaterLockOpenAtom.reportWrite(value, super.isLaterLockOpen, () {
      super.isLaterLockOpen = value;
    });
  }

  final _$_RegisterViewModelBaseActionController =
      ActionController(name: '_RegisterViewModelBase');

  @override
  void isLoadingChange() {
    final _$actionInfo = _$_RegisterViewModelBaseActionController.startAction(
        name: '_RegisterViewModelBase.isLoadingChange');
    try {
      return super.isLoadingChange();
    } finally {
      _$_RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFirstLockStateChange() {
    final _$actionInfo = _$_RegisterViewModelBaseActionController.startAction(
        name: '_RegisterViewModelBase.isFirstLockStateChange');
    try {
      return super.isFirstLockStateChange();
    } finally {
      _$_RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLaterLockStateChange() {
    final _$actionInfo = _$_RegisterViewModelBaseActionController.startAction(
        name: '_RegisterViewModelBase.isLaterLockStateChange');
    try {
      return super.isLaterLockStateChange();
    } finally {
      _$_RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isFirstLockOpen: ${isFirstLockOpen},
isLaterLockOpen: ${isLaterLockOpen}
    ''';
  }
}
