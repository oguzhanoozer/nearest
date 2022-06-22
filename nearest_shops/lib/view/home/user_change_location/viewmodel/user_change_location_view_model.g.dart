// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_change_location_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserChangeLocationViewModel on _UserChangeLocationViewModelBase, Store {
  final _$locationAtom =
      Atom(name: '_UserChangeLocationViewModelBase.location');

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

  final _$_updateGeoPointAtom =
      Atom(name: '_UserChangeLocationViewModelBase._updateGeoPoint');

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

  final _$markersAtom = Atom(name: '_UserChangeLocationViewModelBase.markers');

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
      Atom(name: '_UserChangeLocationViewModelBase.newGoogleMapController');

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
      Atom(name: '_UserChangeLocationViewModelBase.isMapDataLoading');

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

  final _$isSearchPredictLaodingAtom =
      Atom(name: '_UserChangeLocationViewModelBase.isSearchPredictLaoding');

  @override
  bool get isSearchPredictLaoding {
    _$isSearchPredictLaodingAtom.reportRead();
    return super.isSearchPredictLaoding;
  }

  @override
  set isSearchPredictLaoding(bool value) {
    _$isSearchPredictLaodingAtom
        .reportWrite(value, super.isSearchPredictLaoding, () {
      super.isSearchPredictLaoding = value;
    });
  }

  final _$predictionsAtom =
      Atom(name: '_UserChangeLocationViewModelBase.predictions');

  @override
  ObservableList<AutocompletePrediction> get predictions {
    _$predictionsAtom.reportRead();
    return super.predictions;
  }

  @override
  set predictions(ObservableList<AutocompletePrediction> value) {
    _$predictionsAtom.reportWrite(value, super.predictions, () {
      super.predictions = value;
    });
  }

  final _$autoCompleteSearchAsyncAction =
      AsyncAction('_UserChangeLocationViewModelBase.autoCompleteSearch');

  @override
  Future<void> autoCompleteSearch(String value) {
    return _$autoCompleteSearchAsyncAction
        .run(() => super.autoCompleteSearch(value));
  }

  final _$getLocationPermissionAsyncAction =
      AsyncAction('_UserChangeLocationViewModelBase.getLocationPermission');

  @override
  Future<Position?> getLocationPermission() {
    return _$getLocationPermissionAsyncAction
        .run(() => super.getLocationPermission());
  }

  final _$getCurrentLocationPositionAsyncAction = AsyncAction(
      '_UserChangeLocationViewModelBase.getCurrentLocationPosition');

  @override
  Future<void> getCurrentLocationPosition() {
    return _$getCurrentLocationPositionAsyncAction
        .run(() => super.getCurrentLocationPosition());
  }

  final _$updateGeoPointLocationAsyncAction =
      AsyncAction('_UserChangeLocationViewModelBase.updateGeoPointLocation');

  @override
  Future<void> updateGeoPointLocation() {
    return _$updateGeoPointLocationAsyncAction
        .run(() => super.updateGeoPointLocation());
  }

  final _$_updateShopLocationAsyncAction =
      AsyncAction('_UserChangeLocationViewModelBase._updateShopLocation');

  @override
  Future<void> _updateShopLocation(GeoPoint currentLocation) {
    return _$_updateShopLocationAsyncAction
        .run(() => super._updateShopLocation(currentLocation));
  }

  final _$updatePositionWithSelectedLocationAsyncAction = AsyncAction(
      '_UserChangeLocationViewModelBase.updatePositionWithSelectedLocation');

  @override
  Future<void> updatePositionWithSelectedLocation(
      AutocompletePrediction placePrediction) {
    return _$updatePositionWithSelectedLocationAsyncAction
        .run(() => super.updatePositionWithSelectedLocation(placePrediction));
  }

  final _$_UserChangeLocationViewModelBaseActionController =
      ActionController(name: '_UserChangeLocationViewModelBase');

  @override
  void changDataLoadingMap() {
    final _$actionInfo =
        _$_UserChangeLocationViewModelBaseActionController.startAction(
            name: '_UserChangeLocationViewModelBase.changDataLoadingMap');
    try {
      return super.changDataLoadingMap();
    } finally {
      _$_UserChangeLocationViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeIsSearchPredictLaoding() {
    final _$actionInfo =
        _$_UserChangeLocationViewModelBaseActionController.startAction(
            name:
                '_UserChangeLocationViewModelBase.changeIsSearchPredictLaoding');
    try {
      return super.changeIsSearchPredictLaoding();
    } finally {
      _$_UserChangeLocationViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void addMarker(LatLng pos, bool isEnabled) {
    final _$actionInfo = _$_UserChangeLocationViewModelBaseActionController
        .startAction(name: '_UserChangeLocationViewModelBase.addMarker');
    try {
      return super.addMarker(pos, isEnabled);
    } finally {
      _$_UserChangeLocationViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setCameraLocation(LatLng newPosition) {
    final _$actionInfo =
        _$_UserChangeLocationViewModelBaseActionController.startAction(
            name: '_UserChangeLocationViewModelBase.setCameraLocation');
    try {
      return super.setCameraLocation(newPosition);
    } finally {
      _$_UserChangeLocationViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
location: ${location},
markers: ${markers},
newGoogleMapController: ${newGoogleMapController},
isMapDataLoading: ${isMapDataLoading},
isSearchPredictLaoding: ${isSearchPredictLaoding},
predictions: ${predictions}
    ''';
  }
}
