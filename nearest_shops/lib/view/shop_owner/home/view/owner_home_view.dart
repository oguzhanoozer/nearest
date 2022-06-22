import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/button_shadow.dart';
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
      onPageBuilder: (context, OwnerHomeViewModel viewModel) => buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(BuildContext context, OwnerHomeViewModel viewModel) {
    return Scaffold(
      key: viewModel.scaffoldState,
      body: Observer(builder: (_) {
        return viewModel.isMapDataLoading
            ? CallCircularProgress(context)
            : Stack(
                fit: StackFit.expand,
                children: [
                  buildGoogleMapContainer(context, viewModel),
                  Padding(
                    padding: context.horizontalPaddingNormal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        context.emptySizedHeightBoxLow3x,
                        buildSearchTextField(context, viewModel),
                        Observer(builder: (_) {
                          return viewModel.isSearchPredictLaoding
                              ? Expanded(
                                  child: buildListView(viewModel),
                                )
                              : Expanded(child: SizedBox(height: 0));
                        }),
                        context.emptySizedHeightBoxHigh,
                      ],
                    ),
                  ),
                  buildSelectUseLocationButton(context, viewModel)
                ],
              );
      }),
    );
  }

  Widget buildListView(OwnerHomeViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.predictions.length,
      itemBuilder: (context, index) {
        return Container(
          color: context.colorScheme.onSecondary,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: context.colorScheme.onSurfaceVariant,
              child: Icon(
                Icons.location_pin,
                color: context.colorScheme.inversePrimary,
              ),
            ),
            title: Text(viewModel.predictions[index].description ?? "", style: priceTextStyle(context)),
            onTap: () async {
              debugPrint(viewModel.predictions[index].placeId);
              await viewModel.updatePositionWithSelectedLocation(viewModel.predictions[index]);
              viewModel.predictions.clear();
            },
          ),
        );
      },
    );
  }

  Positioned buildSelectUseLocationButton(BuildContext context, OwnerHomeViewModel viewModel) {
    return Positioned(
      bottom: 10,
      right: context.dynamicWidth(0.2),
      left: context.dynamicWidth(0.2),
      child: Observer(builder: (_) {
        return NormalButton(
          child: viewModel.isEnableUpdating
              ? buildUpdateText(LocaleKeys.saveLocationText.locale, context)
              : buildUpdateText(LocaleKeys.updateLocationText.locale, context),
          onPressed: () async {
            viewModel.isEnableUpdating ? viewModel.updateGeoPointLocation() : viewModel.changeUpdateEnable();
          },
          color: context.appTheme.colorScheme.onSurfaceVariant,
        );
      }),
    );
  }

  Text buildUpdateText(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lora(textStyle: context.textTheme.titleMedium!.copyWith(color: context.colorScheme.inversePrimary)),
    );
  }

  GoogleMap buildGoogleMapContainer(BuildContext context, OwnerHomeViewModel viewModel) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      initialCameraPosition: viewModel.initialCameraPosition,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controllerGoogleMap.complete(controller);
        viewModel.newGoogleMapController = controller;
      },
      markers: viewModel.markers,
    );
  }

  Widget buildSearchTextField(BuildContext context, OwnerHomeViewModel viewModel) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: viewModel.searchInputTextController,
        onChanged: (value) async {
          if (viewModel.debounceForSearch?.isActive ?? false) viewModel.debounceForSearch!.cancel();
          viewModel.debounceForSearch = Timer(context.durationNormal, () async {
            if (value.isNotEmpty) {
              await viewModel.autoCompleteSearch(value);
            } else {
              viewModel.predictions.clear();
              viewModel.searchInputTextController.clear();
            }
          });
        },
        textAlignVertical: TextAlignVertical.center,
        validator: (value) => null,
        obscureText: false,
        enabled: viewModel.isEnableUpdating,
        decoration: buildInputDecoration(
          context,
          hintText: viewModel.location,
        ),
      );
    });
  }
}
