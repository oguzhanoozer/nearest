/*import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class OwnerHomeView extends StatefulWidget {
  @override
  _OwnerHomeViewState createState() => _OwnerHomeViewState();
}

class _OwnerHomeViewState extends State<OwnerHomeView> {
  late bool serviceEnabled;
  late LocationPermission permission;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position> getLocation() async {
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("enableddddd");
    }

    permission = await _geolocatorPlatform.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        print("buradasin");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  /*
   Future<void> getLocationss() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Location")),
      body: Center(
        child: TextButton(
          onPressed: () async {
            var x = await getLocation();
            print(x);
          },
          child: const Text(
            "Print Geolocation",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
*/

/*



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kartal/kartal.dart';

class CreateFacilityMapView extends StatefulWidget {
  const CreateFacilityMapView({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<CreateFacilityMapView> {
  double lat = 0;
  double lng = 0;
  Position? currentPosition;

  Set<Marker> markers = <Marker>{};

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? newGoogleMapController;

  String location = "Click to search find address";

  static final CameraPosition _GooglePlex =
      CameraPosition(target: LatLng(38.9637, 35.2433), zoom: 4);

  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: EnvConnection.instance.googleMapsApiKey);

  late bool serviceEnabled;
  late LocationPermission permission;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position> getLocation() async {
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("enableddddd");
    }

    permission = await _geolocatorPlatform.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        print("buradasin");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<void> locatePosition() async {
    Position position = await getLocation();
    currentPosition = position;
    LatLng latlonPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latlonPosition, zoom: 14);
    newGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    _add(latlonPosition);
  }

  @override
  void initState() {
    super.initState();
  }

  void _add(LatLng pos) {
    String markerIdVal = "Your Location";
    final MarkerId markerId = MarkerId(markerIdVal);

    Marker marker = Marker(
        markerId: markerId,
        position: pos,
        draggable: true,
        infoWindow: InfoWindow(title: markerIdVal),
        onTap: () {},
        onDragEnd: ((newPosition) {
          _getLocation(newPosition);
        }));

    setState(() {
      markers = <Marker>{marker};
      lat = pos.latitude;
      lng = pos.longitude;
    });
  }

  void _getLocation(LatLng newPosition) {
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPosition, zoom: 14)));

    setState(() {
      lat = newPosition.latitude;
      lng = newPosition.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _GooglePlex,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locatePosition();
            },
            markers: markers,
          ),
          buildSearchTextField(context),
          Positioned(
              //search input bar
              bottom: 0,
              child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            //  Navigator.push(context, MaterialPageRoute(builder: (context) =>  FacilityConfirmationView(fullAddress: location, position: LatLng(lat,lng))));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 30),
                            alignment: Alignment.center,
                          ),
                          child: Container(
                              child: Text("Use Selected Location",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 18)))),
                    ),
                  )))
        ],
      ),
    );
  }

  Future<void> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);

      double lat = (detail.result.geometry?.location.lat)!;
      double lng = (detail.result.geometry?.location.lng)!;
      var markerIdVal = "facility";
      final MarkerId markerId = MarkerId(markerIdVal);
      CameraPosition pos =
          new CameraPosition(target: LatLng(lat, lng), zoom: 14);

      Marker marker = Marker(
          markerId: markerId,
          position: LatLng(lat, lng),
          draggable: true,
          infoWindow: InfoWindow(title: "New Facility"),
          onTap: () {},
          onDragEnd: ((newPosition) {
            _getLocation(newPosition);
          }));

      setState(() {
        markers = markers = <Marker>{marker};
      });
      newGoogleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(pos));
    }
  }

  Positioned buildSearchTextField(BuildContext context) {
    return Positioned(
      top: context.dynamicHeight(0.03),
      right: context.dynamicHeight(0.03),
      left: context.dynamicHeight(0.03),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        validator: (value) => null,
        obscureText: false,
        decoration: buildTextFormFieldsDecoration(context),
        onTap: () async {
          Prediction? p = await PlacesAutocomplete.show(
              radius: 10,
              mode: Mode.overlay,
              language: "tr",
              logo: Text(""),
              components: [Component(Component.country, "re")],
              context: context,
              textDecoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.red,
                  filled: true),
              cursorColor: Colors.red,
              apiKey: EnvConnection.instance.googleMapsApiKey);
          setState(() {
            location = (p?.description)!;
          });
          displayPrediction(p!);
        },
      ),
    );
  }

  InputDecoration buildTextFormFieldsDecoration(BuildContext context) {
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
      hintText: location,
      suffixIcon: IconButton(
        icon: Icon(Icons.search),
        onPressed: () async {
          Prediction? p = await PlacesAutocomplete.show(
              context: context,
              apiKey: EnvConnection.instance.googleMapsApiKey);
          setState(() {
            location = (p?.description)!;
          });
          displayPrediction(p!);
        },
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

*/