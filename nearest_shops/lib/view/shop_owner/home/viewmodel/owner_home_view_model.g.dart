// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OwnerHomeViewModel on _OwnerHomeViewModelBase, Store {
  final _$markersAtom = Atom(name: '_OwnerHomeViewModelBase.markers');

  @override
  Set<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Set<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$newGoogleMapControllerAtom =
      Atom(name: '_OwnerHomeViewModelBase.newGoogleMapController');

  @override
  GoogleMapController? get newGoogleMapController {
    _$newGoogleMapControllerAtom.reportRead();
    return super.newGoogleMapController;
  }

  @override
  set newGoogleMapController(GoogleMapController? value) {
    _$newGoogleMapControllerAtom
        .reportWrite(value, super.newGoogleMapController, () {
      super.newGoogleMapController = value;
    });
  }

  final _$isMapDataLoadingAtom =
      Atom(name: '_OwnerHomeViewModelBase.isMapDataLoading');

  @override
  bool get isMapDataLoading {
    _$isMapDataLoadingAtom.reportRead();
    return super.isMapDataLoading;
  }

  @override
  set isMapDataLoading(bool value) {
    _$isMapDataLoadingAtom.reportWrite(value, super.isMapDataLoading, () {
      super.isMapDataLoading = value;
    });
  }

  final _$gerCurrentLocationPositionAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.gerCurrentLocationPosition');

  @override
  Future<void> gerCurrentLocationPosition() {
    return _$gerCurrentLocationPositionAsyncAction
        .run(() => super.gerCurrentLocationPosition());
  }

  final _$updateShopLocationAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.updateShopLocation');

  @override
  Future<void> updateShopLocation(
      {required double latitude, required double longtitude}) {
    return _$updateShopLocationAsyncAction.run(() =>
        super.updateShopLocation(latitude: latitude, longtitude: longtitude));
  }

  final _$_OwnerHomeViewModelBaseActionController =
      ActionController(name: '_OwnerHomeViewModelBase');

  @override
  void changDataLoadingMap() {
    final _$actionInfo = _$_OwnerHomeViewModelBaseActionController.startAction(
        name: '_OwnerHomeViewModelBase.changDataLoadingMap');
    try {
      return super.changDataLoadingMap();
    } finally {
      _$_OwnerHomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
markers: ${markers},
newGoogleMapController: ${newGoogleMapController},
isMapDataLoading: ${isMapDataLoading}
    ''';
  }
}
