part of '../owner_product_list_view.dart';

extension _Owner_product_extension on OwnerProductListMapView {
  Positioned buildSelectUseLocationButton(BuildContext context) {
    return Positioned(
        bottom: context.dynamicHeight(0.01),
        right: context.dynamicWidth(0.2),
        left: context.dynamicWidth(0.2),
        child: NormalButton(
          child: buildUpdateText(LocaleKeys.updateLocationText.locale, context),
          onPressed: () async {
            Navigator.pushNamed(context, userChangeLocationViewRoute);
          },
          color: context.appTheme.colorScheme.onSurfaceVariant,
        ));
  }

  Text buildUpdateText(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lora(textStyle: context.textTheme.titleMedium!.copyWith(color: context.colorScheme.inversePrimary)),
    );
  }

  Positioned buildSearchTextField(BuildContext context, OwnerProductListViewModel viewmodel) {
    return Positioned(
      top: context.dynamicHeight(0.03),
      right: context.dynamicHeight(0.03),
      left: context.dynamicHeight(0.03),
      child: TypeAheadField<ShopModel?>(
        loadingBuilder: (context) {
          return CallCircularProgress(context);
        },
        hideKeyboard: false,
        debounceDuration: context.durationLow,

        ///hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: viewmodel.searcpInputTExtFieldController,
          style: inputTextStyle(context),
          textAlignVertical: TextAlignVertical.center,
          obscureText: false,
          textInputAction: TextInputAction.search,
          decoration: buildInputDecoration(
            context,
            hintText: LocaleKeys.enterShopNameText.locale,
            fillColor: context.colorScheme.onSecondary,
          ),
        ),
        suggestionsCallback: viewmodel.filterShopList,
        itemBuilder: (context, ShopModel? suggestion) {
          final shop = suggestion!;

          return Container(
            color: context.colorScheme.onSecondary,
            child: ListTile(
              leading: SizedBox(
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(0.1),
                child: shop.logoUrl!.isEmpty
                    ? Padding(
                        padding: context.paddingLow,
                        child: Lottie.asset(
                          ImagePaths.instance.shop_lottie3,
                          repeat: true,
                          reverse: true,
                          animate: true,
                        ),
                      )
                    : buildImageNetwork(shop.logoUrl ?? "", context),
              ),
              title: Text(shop.name.toString(), style: titleTextStyle(context)),
            ),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: context.dynamicHeight(0.1),
          width: context.dynamicWidth(1),
          color: context.colorScheme.onSecondary,
          child: Center(
            child: Text(LocaleKeys.anyProductFound.locale, style: inputTextStyle(context)),
          ),
        ),
        onSuggestionSelected: (ShopModel? suggestion) {
          final shopModel = suggestion!;

          viewmodel.changeCameraPosition(shopModel.location!);
        },
      ),
    );
  }
}
