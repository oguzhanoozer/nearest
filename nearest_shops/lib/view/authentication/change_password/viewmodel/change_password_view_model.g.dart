// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangePasswordViewModel on _ChangePasswordViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_ChangePasswordViewModelBase.isLoading');

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
      Atom(name: '_ChangePasswordViewModelBase.isFirstLockOpen');

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
      Atom(name: '_ChangePasswordViewModelBase.isLaterLockOpen');

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

  final _$isCurrentLockOpenAtom =
      Atom(name: '_ChangePasswordViewModelBase.isCurrentLockOpen');

  @override
  bool get isCurrentLockOpen {
    _$isCurrentLockOpenAtom.reportRead();
    return super.isCurrentLockOpen;
  }

  @override
  set isCurrentLockOpen(bool value) {
    _$isCurrentLockOpenAtom.reportWrite(value, super.isCurrentLockOpen, () {
      super.isCurrentLockOpen = value;
    });
  }

  final _$updataPasswordAsyncAction =
      AsyncAction('_ChangePasswordViewModelBase.updataPassword');

  @override
  Future<void> updataPassword() {
    return _$updataPasswordAsyncAction.run(() => super.updataPassword());
  }

  final _$_ChangePasswordViewModelBaseActionController =
      ActionController(name: '_ChangePasswordViewModelBase');

  @override
  void isFirstLockStateChange() {
    final _$actionInfo =
        _$_ChangePasswordViewModelBaseActionController.startAction(
            name: '_ChangePasswordViewModelBase.isFirstLockStateChange');
    try {
      return super.isFirstLockStateChange();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLaterLockStateChange() {
    final _$actionInfo =
        _$_ChangePasswordViewModelBaseActionController.startAction(
            name: '_ChangePasswordViewModelBase.isLaterLockStateChange');
    try {
      return super.isLaterLockStateChange();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isCurrentLockOpenchange() {
    final _$actionInfo =
        _$_ChangePasswordViewModelBaseActionController.startAction(
            name: '_ChangePasswordViewModelBase.isCurrentLockOpenchange');
    try {
      return super.isCurrentLockOpenchange();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingChange() {
    final _$actionInfo = _$_ChangePasswordViewModelBaseActionController
        .startAction(name: '_ChangePasswordViewModelBase.isLoadingChange');
    try {
      return super.isLoadingChange();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isFirstLockOpen: ${isFirstLockOpen},
isLaterLockOpen: ${isLaterLockOpen},
isCurrentLockOpen: ${isCurrentLockOpen}
    ''';
  }
}
