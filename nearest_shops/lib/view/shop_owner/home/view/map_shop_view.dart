import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/components/button/normal_button.dart';
import '../../../../../core/base/view/base_view.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../viewmodel/owner_home_view_model.dart';

class MapShowView extends StatefulWidget {
  const MapShowView({Key? key}) : super(key: key);
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<MapShowView> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerHomeViewModel>(
      viewModel: OwnerHomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, OwnerHomeViewModel viewModel) =>
          buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(BuildContext context, OwnerHomeViewModel viewModel) {
    return Scaffold(
      key: viewModel.scaffoldState,
      body: Observer(builder: (_) {
        return viewModel.isMapDataLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  buildGoogleMapContainer(context, viewModel),
                  buildSearchTextField(context, viewModel),
                  buildSelectUseLocationButton(context, viewModel)
                ],
              );
      }),
    );
  }

  Positioned buildSelectUseLocationButton(
      BuildContext context, OwnerHomeViewModel viewModel) {
    return Positioned(
      bottom: 10,
      right: context.dynamicWidth(0.2),
      left: context.dynamicWidth(0.2),
      child: NormalButton(
        child: Text(
          "Use Selected Location",
          style: context.textTheme.bodyText1!
              .copyWith(color: context.appTheme.colorScheme.onPrimary),
        ),
        onPressed: () async {
          await FirebaseAuthentication.instance.signOut();
          // await viewModel.updateShopLocation(latitude: 40, longtitude: 32);
        },
        color: context.appTheme.colorScheme.onSecondary,
      ),
    );
  }

  GoogleMap buildGoogleMapContainer(
      BuildContext context, OwnerHomeViewModel viewModel) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      initialCameraPosition: viewModel.initialCameraPosition,
      zoomGesturesEnabled: true,
      ///myLocationEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controllerGoogleMap.complete(controller);
        viewModel.newGoogleMapController = controller;
      },
      markers: viewModel.markers,
    );
  }

  Positioned buildSearchTextField(
      BuildContext context, OwnerHomeViewModel viewModel) {
    return Positioned(
      top: context.dynamicHeight(0.03),
      right: context.dynamicHeight(0.03),
      left: context.dynamicHeight(0.03),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        validator: (value) => null,
        obscureText: false,
        decoration: buildTextFormFieldsDecoration(context, viewModel),
        onTap: () async {
          await viewModel.getPlaceAutoComplete(context);
        },
      ),
    );
  }

  InputDecoration buildTextFormFieldsDecoration(
      BuildContext context, OwnerHomeViewModel viewModel) {
    return InputDecoration(
      fillColor: context.colorScheme.onSecondary,
      contentPadding: EdgeInsets.zero,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.5,
          color: context.colorScheme.surface.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      hintStyle: context.textTheme.titleMedium!
          .copyWith(color: context.colorScheme.surface),
      hintText: viewModel.location,
      suffixIcon: IconButton(
        icon: Icon(Icons.search),
        onPressed: () async {
          await viewModel.getPlaceAutoComplete(context);
        },
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
/*import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';

import '../../../../core/constants/env_connect/env_connection.dart';
import '../service/shop_owner_home_service.dart';
part 'owner_home_view_model.g.dart';

class OwnerHomeViewModel = _OwnerHomeViewModelBase with _$OwnerHomeViewModel;

abstract class _OwnerHomeViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  late IShopOwnerHomeService shopOwnerHomeService;

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

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
  ObservableSet<Marker> markers = ObservableSet();

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

    markers = ObservableSet.of([marker]);
  }

  @action
  void setCameraLocation(LatLng newPosition) {
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPosition, zoom: 6)));
    
  }

  @action
  Future<void> displayPrediction(Prediction p) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);

    double lat = (detail.result.geometry?.location.lat)!;
    double lng = (detail.result.geometry?.location.lng)!;

    addMarker(LatLng(lat, lng));
    setCameraLocation(LatLng(lat, lng));
  }

  @action
  Future<void> getPlaceAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
        overlayBorderRadius: BorderRadius.all(Radius.circular(20)),
        
        mode: Mode.overlay,
        language: "tr",
        logo: const SizedBox(),
        components: [Component(Component.country, "tr")],
        context: context,
        cursorColor: Colors.red,
        apiKey: EnvConnection.instance.googleMapsApiKey);

    
    location = (p?.description)!;

    
    await displayPrediction(p!);
  }
}
*/