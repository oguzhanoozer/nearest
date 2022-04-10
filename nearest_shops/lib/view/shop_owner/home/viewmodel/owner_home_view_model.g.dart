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

  final _$displayPredictionAsyncAction =
      AsyncAction('_OwnerHomeViewModelBase.displayPrediction');

  @override
  Future<void> displayPrediction(Prediction p) {
    return _$displayPredictionAsyncAction.run(() => super.displayPrediction(p));
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
  void addMarker(LatLng pos) {
    final _$actionInfo = _$_OwnerHomeViewModelBaseActionController.startAction(
        name: '_OwnerHomeViewModelBase.addMarker');
    try {
      return super.addMarker(pos);
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
markers: ${markers},
newGoogleMapController: ${newGoogleMapController},
isMapDataLoading: ${isMapDataLoading}
    ''';
  }
}
