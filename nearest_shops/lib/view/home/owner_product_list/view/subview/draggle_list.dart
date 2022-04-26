import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/product_list_view/product_list_view.dart';
import '../../viewmodel/owner_product_list_view_model.dart';

class DraggleList {
  Widget makeDismissble(
      {required Widget child,
      required BuildContext context,
      required OwnerProductListViewModel ownerProductListViewModel}) {
    return Observer(builder: (_) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            ownerProductListViewModel.changeIsShopProductLoaded(false);
            Navigator.of(context).pop();
          },
          child: child);
    });
  }

  Widget buildDraggeableContainer(BuildContext context,
      OwnerProductListViewModel ownerProductListViewModel) {
    return makeDismissble(
      context: context,
      ownerProductListViewModel: ownerProductListViewModel,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (DraggableScrollableNotification DSNotification) {
          //if (DSNotification.extent >= 0.2) {
          //  changeIsShopProductLoaded();
          //  print("oguzhan");
          //}
          // else
          if (DSNotification.extent < 0.2) {
            ownerProductListViewModel.changeIsShopProductLoaded(false);
          }
          return false;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 0.8,
          minChildSize: 0.0,
          snap: true,
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
                child: ownerProductListViewModel.isShopProductLoading
                    ? Center(child: CircularProgressIndicator())
                    : buildProductListView(
                        myscrollController, context, ownerProductListViewModel),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildProductListView(
      ScrollController myscrollController,
      BuildContext context,
      OwnerProductListViewModel ownerProductListViewModel) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ownerProductListViewModel.getShopModel().name!,
            style: context.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Divider(
            color: context.colorScheme.primary,
            height: 5.0,
            thickness: 5.0,
          ),
          Expanded(
            child: ListView.builder(
              controller: myscrollController,
              itemCount:
                  ownerProductListViewModel.getListProductDetailModel().length,
              itemBuilder: (BuildContext context, int index) {
                return buildProductCard(
                    context, index, ownerProductListViewModel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(BuildContext context, int index,
      OwnerProductListViewModel ownerProductListViewModel) {
    return ProductListView(
      
      productDetailModel:
          ownerProductListViewModel.getListProductDetailModel()[index],
      shopModel: null,
      rightSideWidget:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
          iconSize: 30,
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.favorite,
            color: context.colorScheme.onPrimaryContainer,
          ),
          onPressed: null,
        ),
      ]),
    );
  }
}
