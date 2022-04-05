// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_onboard_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DashboardOnBoardViewModel on _DashboardOnBoardViewModelBase, Store {
  final _$_userRoleAtom =
      Atom(name: '_DashboardOnBoardViewModelBase._userRole');

  @override
  int? get _userRole {
    _$_userRoleAtom.reportRead();
    return super._userRole;
  }

  @override
  set _userRole(int? value) {
    _$_userRoleAtom.reportWrite(value, super._userRole, () {
      super._userRole = value;
    });
  }

  final _$isDashboardLoadingAtom =
      Atom(name: '_DashboardOnBoardViewModelBase.isDashboardLoading');

  @override
  bool get isDashboardLoading {
    _$isDashboardLoadingAtom.reportRead();
    return super.isDashboardLoading;
  }

  @override
  set isDashboardLoading(bool value) {
    _$isDashboardLoadingAtom.reportWrite(value, super.isDashboardLoading, () {
      super.isDashboardLoading = value;
    });
  }

  final _$getUserRoleAsyncAction =
      AsyncAction('_DashboardOnBoardViewModelBase.getUserRole');

  @override
  Future<void> getUserRole() {
    return _$getUserRoleAsyncAction.run(() => super.getUserRole());
  }

  final _$_DashboardOnBoardViewModelBaseActionController =
      ActionController(name: '_DashboardOnBoardViewModelBase');

  @override
  void changeIsDashboardLoading() {
    final _$actionInfo =
        _$_DashboardOnBoardViewModelBaseActionController.startAction(
            name: '_DashboardOnBoardViewModelBase.changeIsDashboardLoading');
    try {
      return super.changeIsDashboardLoading();
    } finally {
      _$_DashboardOnBoardViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDashboardLoading: ${isDashboardLoading}
    ''';
  }
}
