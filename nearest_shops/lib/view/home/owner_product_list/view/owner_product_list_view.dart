import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/product_list_view/product_list_view.dart';
import '../viewmodel/owner_product_list_view_model.dart';
import 'map_shop_view.dart';

part 'subview/owner_product_extension.dart';

class OwnerUserProductListView extends StatelessWidget {
  const OwnerUserProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerProductListViewModel>(
      viewModel: OwnerProductListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, OwnerProductListViewModel viewmodel) =>
              buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(
      BuildContext context, OwnerProductListViewModel viewmodel) {
    return Observer(builder: (_) {
      return Scaffold(
        key: viewmodel.scaffoldState,
        body: viewmodel.isShopMapLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  MapShopView(viewModel: viewmodel),
                  buildSearchTextField(context),
                  //viewmodel.isShopProductDraggleLoaded
                  ///  ? buildDraggeableContainer(viewmodel, context)
                  // : Container()
                  // AnimatedCrossFade(
                  //   duration: Duration(milliseconds: 2000),
                  //   reverseDuration: Duration(milliseconds: 600),
                  //   crossFadeState: viewmodel.isShopProductDraggleLoaded
                  //       ? CrossFadeState.showSecond
                  //       : CrossFadeState.showFirst,
                  //   firstChild: Container(),
                  //   secondChild: buildDraggeableContainer(viewmodel, context),
                  // )

                  ///viewmodel.isShopProductDraggleLoaded                      ? buildDraggeableContainer(viewmodel)                      : Container()
                ],
              ),
      );
    });
  }

  Widget makeDismissble(
      {required Widget child,
      required BuildContext context,
      required OwnerProductListViewModel viewmodel}) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          viewmodel.changeIsShopProductLoaded(false);

          ///  Navigator.of(context).pop();
        },
        child: child);
  }

  Widget buildDraggeableContainer(
      OwnerProductListViewModel viewmodel, BuildContext context) {
    return makeDismissble(
      context: context,
      viewmodel: viewmodel,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (DraggableScrollableNotification DSNotification) {
          //if (DSNotification.extent >= 0.2) {
          //  changeIsShopProductLoaded();
          //  print("oguzhan");
          //}
          // else
          if (DSNotification.extent < 0.2) {
            viewmodel.changeIsShopProductLoaded(false);
          }
          return false;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 0.8,

          minChildSize: 0.0,
          //  snap: true,
          //expand: false,
          builder: (BuildContext context, myscrollController) {
            return Padding(
              padding: context.horizontalPaddingLow,
              child: Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.normalValue),
                    topRight: Radius.circular(context.normalValue),
                  ),
                ),
                child: viewmodel.isShopProductLoading
                    ? Center(child: CircularProgressIndicator())
                    : buildProductListView(
                        myscrollController, context, viewmodel),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildProductListView(ScrollController myscrollController,
      BuildContext context, OwnerProductListViewModel viewmodel) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewmodel.getShopName(),
            style: context.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              controller: myscrollController,
              itemCount: viewmodel.getListProductDetailModel().length,
              itemBuilder: (BuildContext context, int index) {
                return buildProductCard(context, viewmodel, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(
      BuildContext context, OwnerProductListViewModel viewmodel, int index) {
    return ProductListView(
      index: index,
      productDetailModel: viewmodel.getListProductDetailModel()[index],
      shopModel: null,
      rightSideWidget:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
          iconSize: 30,
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: null,
        ),
      ]),
    );
  }
}
