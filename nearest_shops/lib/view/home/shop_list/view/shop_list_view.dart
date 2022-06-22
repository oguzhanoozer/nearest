import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';
import '../../../product/shop_product_view/product_list_view.dart';
import '../model/shop_model.dart';
import '../viewmodel/shop_list_view_model.dart';

class ShopListView extends StatelessWidget {
  ShopListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopListViewModel>(
      viewModel: ShopListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ShopListViewModel viewmodel) => buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(
    BuildContext context,
    ShopListViewModel viewmodel,
  ) {
    return SafeArea(
      child: Scaffold(
          key: viewmodel.scaffoldState,
          appBar: buildAppBar(context, viewmodel),
          body: Observer(builder: (_) {
            return viewmodel.isShopMapListLoading ? CallCircularProgress(context) : buildShopList(viewmodel, context);
          })),
    );
  }

  Widget buildShopList(ShopListViewModel viewmodel, BuildContext context) {
    List<ShopModel> currentShopList = viewmodel.shopModelList;

    return Padding(
      padding: context.horizontalPaddingNormal,
      child: currentShopList.isEmpty
          ? Center(
              child: Text(
                LocaleKeys.nearestShopsListEmptyText.locale,
                style: titleTextStyle(context),
              ),
            )
          : ListView.builder(
              itemCount: currentShopList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: context.verticalPaddingLow,
                  child: buildShopCard(context, currentShopList[index], index, viewmodel),
                );
              },
            ),
    );
  }

  Widget buildShopCard(BuildContext context, ShopModel shopModel, int index, ShopListViewModel viewmodel) {
    return ShopProductView(
      productDetailModel: null,
      shopModel: shopModel,
      rightSideWidget: Observer(builder: (_) {
        return Center(
          child: IconButton(
            icon: Icon(Icons.location_on_outlined, size: context.normalValue * 3, color: context.colorScheme.onSurfaceVariant),
            onPressed: () async {
              if (viewmodel.isInterstitialAdReady) {
                viewmodel.paramShopModel = shopModel;
                viewmodel.interstitialAd!.show();
              }
            },
          ),
        );
      }),
    );
  }

  AppBar buildAppBar(BuildContext context, ShopListViewModel viewModel) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.theNearestText.locale,
                style: GoogleFonts.concertOne(
                    textStyle: context.textTheme.headline5!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold)));
      }),
      actions: [
        Observer(builder: (_) {
          return viewModel.isSearching
              ? const SizedBox()
              : Padding(
                  padding: context.horizontalPaddingNormal,
                  child: IconButton(
                    onPressed: () {
                      viewModel.changeIsSearching();
                    },
                    icon: Icon(Icons.search, size: context.dynamicHeight(0.03)),
                  ),
                );
        })
      ],
    );
  }

  Widget getAppBarListTile(BuildContext context, ShopListViewModel viewModel) {
    return ListTile(
      title: TextFormField(
        style: inputTextStyle(context),
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        autofocus: true,
        onFieldSubmitted: (term) {
          viewModel.filterProducts(term);
        },
        decoration: buildInputDecoration(
          context,
          hintText: LocaleKeys.enterShopNameText.locale,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.cancel_sharp,
              size: context.dynamicHeight(0.03),
              color: context.colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              viewModel.changeIsSearching();
            },
          ),
        ),
      ),
    );
  }
}
