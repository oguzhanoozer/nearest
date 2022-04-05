/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/components/button/normal_button.dart';
import '../../../../../core/base/view/base_view.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../viewmodel/owner_home_view_model.dart';

class CreateFacilityMapView extends StatelessWidget {
  CreateFacilityMapView({Key? key}) : super(key: key);

  OwnerHomeViewModel viewModel = OwnerHomeViewModel();

  Completer<GoogleMapController> controllerGoogleMap = Completer();

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

  Widget buildScaffold(BuildContext context, OwnerHomeViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.isMapDataLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              key: viewModel.scaffoldState,
              body: Stack(
                children: [
                  buildGoogleMapContainer(),
                  buildSearchTextField(context),
                  buildSelectUseLocationButton(context, viewModel)
                ],
              ),
            );
    });
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

  Widget buildGoogleMapContainer() {
    final data = viewModel.markers ;
    return GoogleMap(
      markers:data,
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      initialCameraPosition: viewModel.initialCameraPosition,
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        controllerGoogleMap.complete(controller);
        viewModel.newGoogleMapController = controller;
      },
    );
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
          await viewModel.getPlaceAutoComplete(context);
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
*/
