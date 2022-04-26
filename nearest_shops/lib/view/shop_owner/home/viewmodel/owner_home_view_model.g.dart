// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OwnerHomeViewModel on _OwnerHomeViewModelBase, Store {
  final _$locationAtom = Atom(name: '_OwnerHomeViewModelBase.location');

  @override
  String get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(String value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$isEnableUpdatingAtom =
      Atom(name: '_OwnerHomeViewModelBase.isEnableUpdating');

  @override
  bool get isEnableUpdating {
    _$isEnableUpdatingAtom.reportRead();
    return super.isEnableUpdating;
  }

  @override
  set isEnableUpdating(bool value) {
    _$isEnableUpdatingAtom.reportWrite(value, super.isEnableUpdating, () {
      super.isEnableUpdating = value;
    });
  }

  final _$_updateGeoPointAtom =
      Atom(name: '_OwnerHomeViewModelBase._updateGeoPoint');

  @override
  GeoPoint? get _updateGeoPoint {
    _$_updateGeoPointAtom.reportRead();
    return super._updateGeoPoint;
  }

  @override
  set _updateGeoPoint(GeoPoint? value) {
    _$_updateGeoPointAtom.reportWrite(value, super._updateGeoPoint, () {
      super._updateGeoPoint = value;
    });
  }

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

  final _$checkShopLocationAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.checkShopLocation');

  @override
  Future<LatLng?> checkShopLocation() {
    return _$checkShopLocationAsyncAction.run(() => super.checkShopLocation());
  }

  final _$getLocationPermissionAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.getLocationPermission');

  @override
  Future<Position> getLocationPermission() {
    return _$getLocationPermissionAsyncAction
        .run(() => super.getLocationPermission());
  }

  final _$getCurrentLocationPositionAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.getCurrentLocationPosition');

  @override
  Future<void> getCurrentLocationPosition() {
    return _$getCurrentLocationPositionAsyncAction
        .run(() => super.getCurrentLocationPosition());
  }

  final _$updateLocationAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.updateLocation');

  @override
  Future<void> updateLocation() {
    return _$updateLocationAsyncAction.run(() => super.updateLocation());
  }

  final _$updateGeoPointLocationAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.updateGeoPointLocation');

  @override
  Future<void> updateGeoPointLocation() {
    return _$updateGeoPointLocationAsyncAction
        .run(() => super.updateGeoPointLocation());
  }

  final _$_updateShopLocationAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase._updateShopLocation');

  @override
  Future<void> _updateShopLocation(GeoPoint currentLocation) {
    return _$_updateShopLocationAsyncAction
        .run(() => super._updateShopLocation(currentLocation));
  }

  final _$displayPredictionAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.displayPrediction');

  @override
  Future<void> displayPrediction(Prediction placePrediction) {
    return _$displayPredictionAsyncAction
        .run(() => super.displayPrediction(placePrediction));
  }

  final _$getPlaceAutoCompleteAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.getPlaceAutoComplete');

  @override
  Future<void> getPlaceAutoComplete(BuildContext context) {
    return _$getPlaceAutoCompleteAsyncAction
        .run(() => super.getPlaceAutoComplete(context));
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
  void changeUpdateEnable() {
    final _$actionInfo = _$_OwnerHomeViewModelBaseActionController.startAction(
        name: '_OwnerHomeViewModelBase.changeUpdateEnable');
    try {
      return super.changeUpdateEnable();
    } finally {
      _$_OwnerHomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMarker(LatLng pos, bool isEnabled) {
    final _$actionInfo = _$_OwnerHomeViewModelBaseActionController.startAction(
        name: '_OwnerHomeViewModelBase.addMarker');
    try {
      return super.addMarker(pos, isEnabled);
    } finally {
      _$_OwnerHomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCameraLocation(LatLng newPosition) {
    final _$actionInfo = _$_OwnerHomeViewModelBaseActionController.startAction(
        name: '_OwnerHomeViewModelBase.setCameraLocation');
    try {
      return super.setCameraLocation(newPosition);
    } finally {
      _$_OwnerHomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
location: ${location},
isEnableUpdating: ${isEnableUpdating},
markers: ${markers},
newGoogleMapController: ${newGoogleMapController},
isMapDataLoading: ${isMapDataLoading}
    ''';
  }
}
