import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../viewmodel/owner_home_view_model.dart';

class OwnerHomeView extends StatefulWidget {
  const OwnerHomeView({Key? key}) : super(key: key);
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<OwnerHomeView> {
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
      child: Observer(builder: (_) {
        return NormalButton(
          child: viewModel.isEnableUpdating
              ? Text( LocaleKeys.saveLocationText.locale)
              : Text(
                  LocaleKeys.updateLocationText.locale,
                  style: context.textTheme.bodyText1!
                      .copyWith(color: context.appTheme.colorScheme.onPrimary),
                ),
          onPressed: () async {
            viewModel.isEnableUpdating
                ? viewModel.updateGeoPointLocation()
                : viewModel.changeUpdateEnable();
          },
          color: context.appTheme.colorScheme.onSecondary,
        );
      }),
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
        enabled: viewModel.isEnableUpdating,
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
 