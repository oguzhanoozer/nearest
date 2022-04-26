import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/constants/env_connect/env_connection.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../home/shop_list/model/shop_model.dart';
import '../../../utility/error_helper.dart';
import '../service/shop_owner_home_service.dart';

part 'owner_home_view_model.g.dart';

class OwnerHomeViewModel = _OwnerHomeViewModelBase with _$OwnerHomeViewModel;

abstract class _OwnerHomeViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  late IShopOwnerHomeService shopOwnerHomeService;

  late CameraPosition initialCameraPosition;

  final GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: EnvConnection.instance.googleMapsApiKey,
  );
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  late bool serviceEnabled;
  late LocationPermission permission;

  @observable
  String location = "Click to search find address";

  String shopName = "Your Shop";
  @observable
  bool isEnableUpdating = false;

  @observable
  GeoPoint? _updateGeoPoint;

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
    getCurrentLocationPosition();
  }

  @action
  void changDataLoadingMap() {
    isMapDataLoading = !isMapDataLoading;
  }

  @action
  Future<LatLng?> checkShopLocation() async {
    ShopModel? shopModel = await shopOwnerHomeService.fetchShopLocation();
    if (shopModel != null) {
      shopName = shopModel.name!;
      if (shopModel.location != null) {
        return LatLng(
            shopModel.location!.latitude, shopModel.location!.longitude);
      }
    }
    return null;
  }

  @action
  void changeUpdateEnable() {
    isEnableUpdating = true;
    updateLocation();
  }

  @action
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

  @action
  Future<void> getCurrentLocationPosition() async {
    changDataLoadingMap();
    LatLng? savedLocation;

    savedLocation = await checkShopLocation();
    if (savedLocation == null) {
      Position position = await getLocationPermission();

      savedLocation = LatLng(position.latitude, position.longitude);
      await _updateShopLocation(
          GeoPoint(savedLocation.latitude, savedLocation.longitude));
    }

    ///setCameraLocation(savedLocation);
    initialCameraPosition = CameraPosition(target: savedLocation, zoom: 6);
    addMarker(savedLocation,false);
    changDataLoadingMap(); 
  }

  @action
  Future<void> updateLocation() async {
    if (isEnableUpdating) {
      LatLng? savedLocation;

      Position position = await getLocationPermission();

      savedLocation = LatLng(position.latitude, position.longitude);

      ///      await _updateGeoPointLocation(GeoPoint(position.latitude, position.longitude));
      _updateGeoPoint = GeoPoint(position.latitude, position.longitude);

      setCameraLocation(savedLocation);

      ///      initialCameraPosition = CameraPosition(target: savedLocation, zoom: 6);
      addMarker(savedLocation,true);
    }
  }

  @action
  Future<void> updateGeoPointLocation() async {
    if (isEnableUpdating) {
      if (_updateGeoPoint != null) {
        await _updateShopLocation(_updateGeoPoint!);
      } else {
        showSnackBar(
            scaffoldState, context!, LocaleKeys.locationWasNotUpdatedText.locale);
      }

      isEnableUpdating = false;
    }
  }

  @action
  Future<void> _updateShopLocation(GeoPoint currentLocation) async {
    await shopOwnerHomeService.updateShopLocation(currentLocation);
  }

  @action
  void addMarker(LatLng pos,bool isEnabled) {
    String markerIdVal = shopName;

    final MarkerId markerId = MarkerId(markerIdVal);

    markers.clear();
    Marker marker = Marker(
        markerId: markerId,
        position: pos,
        draggable: isEnabled,
        infoWindow: InfoWindow(title: markerIdVal),
        onTap: () {},
        onDragEnd: ((newPosition) async {
          setCameraLocation(newPosition);
          _updateGeoPoint =
              GeoPoint(newPosition.latitude, newPosition.longitude);
        //  isEnableUpdating = false;

          ///await _updateGeoPointLocation(  GeoPoint(newPosition.latitude, newPosition.longitude));
        }));

    markers = <Marker>{marker};
  }

  @action
  void setCameraLocation(LatLng newPosition) {
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPosition, zoom: 8)));
  }

  @action
  Future<void> displayPrediction(Prediction placePrediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(placePrediction.placeId!);
    double lat = (detail.result.geometry?.location.lat)!;
    double lng = (detail.result.geometry?.location.lng)!;

    addMarker(LatLng(lat, lng),true);
    setCameraLocation(LatLng(lat, lng));
    _updateGeoPoint = GeoPoint(lat, lng);

    ///await _updateGeoPointLocation(GeoPoint(lat, lng));
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
        cursorColor: context.colorScheme.onPrimaryContainer,
        apiKey: EnvConnection.instance.googleMapsApiKey);

    if (placePrediction != null && placePrediction.description != null) {
      location = placePrediction.description!;

      await displayPrediction(placePrediction);
    } else {
      location = LocaleKeys.errorLocationNotFoundText.locale;
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnFindingPlaceAddressText.locale);
    }
  }
}
