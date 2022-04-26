import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/grid/product_grid.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../viewModel/categories_view_model.dart';

part 'subview/categories_extension.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoriesViewModel>(
      viewModel: CategoriesViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, CategoriesViewModel viewModel) =>
          buildScaffold(context, viewModel),
    );
  }

  Widget buildScaffold(BuildContext context, CategoriesViewModel viewmodel) =>
      Scaffold(
        appBar: buildAppBar(context, viewmodel),
        body: Observer(builder: (_) {
          return Padding(
              padding: context.paddingNormal,
              child: Column(
                children: [
                  Observer(builder: (_) {
                    return buildCategoriesRow(context, viewmodel);
                  }),
                  viewmodel.isProductFirstListLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: SingleChildScrollView(
                          child: buildProductsGrid(
                              context, viewmodel.productList, viewmodel),
                        )),
                  if (viewmodel.isProductMoreListLoading == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                ],
              ));
        }),
      );

  Widget buildProductsGrid(
      BuildContext context,
      List<ProductDetailModel> productDetailList,
      CategoriesViewModel viewModel) {
    return ProductGrid(
        productList: productDetailList, categoriesViewModel: viewModel);
  }

  AppBar buildAppBar(BuildContext context, CategoriesViewModel viewModel) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.topCategoriesText.locale,
                style: context.textTheme.headline6!.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold));
      }),
      actions: [
        Observer(builder: (_) {
          return viewModel.isSearching
              ? SizedBox()
              : Padding(
                  padding: context.horizontalPaddingNormal,
                  child: IconButton(
                    onPressed: () {
                      viewModel.changeIsSearching();
                    },
                    icon: Icon(Icons.search, size: context.dynamicHeight(0.04)),
                  ),
                );
        })
      ],
    );
  }

  Widget getAppBarListTile(
      BuildContext context, CategoriesViewModel viewModel) {
    return ListTile(
      title: TextFormField(
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        autofocus: true,
        onFieldSubmitted: (term) {
          viewModel.filterText = term;
          viewModel.filterProducts(term);
        },
        decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(8),
            hintText: LocaleKeys.enterShopNameText.locale,
            hintStyle: TextStyle(
              color: context.colorScheme.onSecondary.withOpacity(0.5),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(Icons.search, size: context.dynamicHeight(0.03)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.cancel_sharp, size: context.dynamicHeight(0.03)),
              onPressed: () {
                viewModel.changeIsSearching();
              },
            )),
      ),
    );
  }
}
