import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/constants/env_connect/env_connection.dart';
import '../service/shop_owner_home_service.dart';
part 'owner_home_view_model.g.dart';

class OwnerHomeViewModel = _OwnerHomeViewModelBase with _$OwnerHomeViewModel;

abstract class _OwnerHomeViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  late IShopOwnerHomeService shopOwnerHomeService;

  final CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(38.9637, 35.2433), zoom: 4);

  final GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: EnvConnection.instance.googleMapsApiKey,
  );
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  late bool serviceEnabled;
  late LocationPermission permission;

  @observable
  String location = "Click to search find address";

  @observable
  Set<Marker> markers = <Marker>{};

  @observable
  GoogleMapController? newGoogleMapController;

  @observable
  bool isMapDataLoading = false;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    shopOwnerHomeService = ShopOwnerHomeService(scaffoldState, context);
  }

  @override
  void init() {
    gerCurrentLocationPosition();
  }

  @action
  void changDataLoadingMap() {
    isMapDataLoading = !isMapDataLoading;
  }

  Future<Position> getLocationPermission() async {
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {}
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {}
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<void> gerCurrentLocationPosition() async {
    changDataLoadingMap();

    Position position = await getLocationPermission();

    LatLng latlonPosition = LatLng(position.latitude, position.longitude);
    setCameraLocation(latlonPosition);
    addMarker(latlonPosition);
    changDataLoadingMap();
  }

  @action
  void addMarker(LatLng pos) {
    String markerIdVal = "Your Location";

    final MarkerId markerId = MarkerId(markerIdVal);

    Marker marker = Marker(
        markerId: markerId,
        position: pos,
        draggable: true,
        infoWindow: InfoWindow(title: markerIdVal),
        onTap: () {},
        onDragEnd: ((newPosition) {
          setCameraLocation(newPosition);
        }));

    markers = <Marker>{marker};
  }

  @action
  void setCameraLocation(LatLng newPosition) {
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPosition, zoom: 6)));
  }

  @action
  Future<void> displayPrediction(Prediction placePrediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(placePrediction.placeId!);
    double lat = (detail.result.geometry?.location.lat)!;
    double lng = (detail.result.geometry?.location.lng)!;

    addMarker(LatLng(lat, lng));
    setCameraLocation(LatLng(lat, lng));
  }

  @action
  Future<void> getPlaceAutoComplete(BuildContext context) async {
    Prediction? placePrediction = await PlacesAutocomplete.show(

        ///overlayBorderRadius: BorderRadius.all(Radius.circular(20)),
        strictbounds: false,
        types: [],
        mode: Mode.overlay,
        language: "tr",
        logo: const SizedBox(),
        components: [Component(Component.country, "tr")],
        context: context,
        cursorColor: Colors.red,
        apiKey: EnvConnection.instance.googleMapsApiKey);

    if (placePrediction != null && placePrediction.description != null) {
      location = placePrediction.description!;

      await displayPrediction(placePrediction);
    } else {
      location = "Error not found";
      showSnackBar(scaffoldState, context, "Error in finding place address");
    }
  }
}
