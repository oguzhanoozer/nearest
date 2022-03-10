import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapShopView extends StatefulWidget {
  @override
  _MapShopViewState createState() => _MapShopViewState();
}

double _originLatitude = 40.392300;
double _originLongitude = 30.047840;

class _MapShopViewState extends State<MapShopView> {
  GoogleMapController? _controller;
  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _initalCameraPosition,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
