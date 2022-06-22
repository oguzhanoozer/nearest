// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard_initial_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OnBoardInitialViewModel on _OnBoardInitialViewModelBase, Store {
  final _$_initialApkMoodeAtom =
      Atom(name: '_OnBoardInitialViewModelBase._initialApkMoode');

  @override
  String? get _initialApkMoode {
    _$_initialApkMoodeAtom.reportRead();
    return super._initialApkMoode;
  }

  @override
  set _initialApkMoode(String? value) {
    _$_initialApkMoodeAtom.reportWrite(value, super._initialApkMoode, () {
      super._initialApkMoode = value;
    });
  }

  final _$isInitialModelLoadingAtom =
      Atom(name: '_OnBoardInitialViewModelBase.isInitialModelLoading');

  @override
  bool get isInitialModelLoading {
    _$isInitialModelLoadingAtom.reportRead();
    return super.isInitialModelLoading;
  }

  @override
  set isInitialModelLoading(bool value) {
    _$isInitialModelLoadingAtom.reportWrite(value, super.isInitialModelLoading,
        () {
      super.isInitialModelLoading = value;
    });
  }

  final _$getUserRoleAsyncAction =
      AsyncAction('_OnBoardInitialViewModelBase.getUserRole');

  @override
  Future<void> getUserRole() {
    return _$getUserRoleAsyncAction.run(() => super.getUserRole());
  }

  final _$_OnBoardInitialViewModelBaseActionController =
      ActionController(name: '_OnBoardInitialViewModelBase');

  @override
  void changeIsInitialModeLoading() {
    final _$actionInfo =
        _$_OnBoardInitialViewModelBaseActionController.startAction(
            name: '_OnBoardInitialViewModelBase.changeIsInitialModeLoading');
    try {
      return super.changeIsInitialModeLoading();
    } finally {
      _$_OnBoardInitialViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isInitialModelLoading: ${isInitialModelLoading}
    ''';
  }
}
