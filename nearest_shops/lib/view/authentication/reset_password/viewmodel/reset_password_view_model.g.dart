// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordViewModel on _ResetPasswordViewModelBase, Store {
  final _$isResetEmailSendAtom =
      Atom(name: '_ResetPasswordViewModelBase.isResetEmailSend');

  @override
  bool get isResetEmailSend {
    _$isResetEmailSendAtom.reportRead();
    return super.isResetEmailSend;
  }

  @override
  set isResetEmailSend(bool value) {
    _$isResetEmailSendAtom.reportWrite(value, super.isResetEmailSend, () {
      super.isResetEmailSend = value;
    });
  }

  final _$_ResetPasswordViewModelBaseActionController =
      ActionController(name: '_ResetPasswordViewModelBase');

  @override
  void changeResetEmail() {
    final _$actionInfo = _$_ResetPasswordViewModelBaseActionController
        .startAction(name: '_ResetPasswordViewModelBase.changeResetEmail');
    try {
      return super.changeResetEmail();
    } finally {
      _$_ResetPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isResetEmailSend: ${isResetEmailSend}
    ''';
  }
}
