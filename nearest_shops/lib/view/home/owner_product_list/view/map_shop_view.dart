import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../viewmodel/owner_product_list_view_model.dart';

class MapShopView extends StatelessWidget {
  final OwnerProductListViewModel viewModel;

  const MapShopView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: viewModel.initalCameraPosition,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        markers: viewModel.getListMarkerList(),
        onMapCreated: (GoogleMapController controller) {
          viewModel.newGoogleMapController = controller;
        },
      ),
    );
  }
}
