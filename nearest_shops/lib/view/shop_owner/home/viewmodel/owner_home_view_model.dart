import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';

import '../../../../core/constants/env_connect/env_connection.dart';
import '../service/shop_owner_home_service.dart';
part 'owner_home_view_model.g.dart';

class OwnerHomeViewModel = _OwnerHomeViewModelBase with _$OwnerHomeViewModel;

abstract class _OwnerHomeViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  String location = "Click to search find address";

  CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(40.9637, 35.2433), zoom: 4);

  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: EnvConnection.instance.googleMapsApiKey);

  GeolocatorPlatform geolocatorPlatformInstance = GeolocatorPlatform.instance;

  bool? serviceEnabled;

  LocationPermission? permission;

  @observable
  Set<Marker> markers = <Marker>{};

  @observable
  GoogleMapController? newGoogleMapController;

  @observable
  bool isMapDataLoading = false;

  @override
  void setContext(BuildContext context) {
    this.context = context;
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
    serviceEnabled =
        await geolocatorPlatformInstance.isLocationServiceEnabled();
    if (!serviceEnabled!) {}
    permission = await geolocatorPlatformInstance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatformInstance.requestPermission();
      if (permission == LocationPermission.denied) {}
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

@action
  Future<void> gerCurrentLocationPosition() async {
    changDataLoadingMap();
    Position position = await getLocationPermission();

    LatLng latlonPosition = LatLng(42, 32);
    setCameraLocation(latlonPosition);
    addMarker(latlonPosition);
    changDataLoadingMap();
  }


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
    // setState(() {
    markers.add(marker);
    // });
  }

  void setCameraLocation(LatLng newPosition) {
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPosition, zoom: 14)));
//    setState(() {});
  }

  Future<void> getPlaceAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
        radius: 10,
        mode: Mode.overlay,
        language: "tr",
        logo: Text(""),
        components: [Component(Component.country, "tr")],
        context: context,
        // textDecoration: InputDecoration(
        //     contentPadding: EdgeInsets.all(10),
        //     fillColor: Colors.red,
        //     filled: true),
        cursorColor: Colors.red,
        apiKey: EnvConnection.instance.googleMapsApiKey);
//setState(() {
    location = (p?.description)!;
    //  });
    displayPrediction(p!);
  }

  Future<void> displayPrediction(Prediction p) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    double lat = (detail.result.geometry?.location.lat)!;
    double lng = (detail.result.geometry?.location.lng)!;
    addMarker(LatLng(lat, lng));

    setCameraLocation(LatLng(lat, lng));
  }

  Set<Marker> getLocationMarkerList() {
    return markers;
  }

  @action
  Future<void> updateShopLocation(
      {required double latitude, required double longtitude}) async {
    Map<String, dynamic> updateData = {
      "location": GeoPoint(latitude, longtitude)
    };

    try {
      await ShopOwnerHomeService.instance.updateShopLocation(updateData);
    } on FirebaseException catch (e) {
      if (scaffoldState.currentState != null) {
        scaffoldState.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
            ),
          ),
        );
      }
    }
  }
}
