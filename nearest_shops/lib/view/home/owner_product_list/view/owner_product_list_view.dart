import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../../../product/shop_product_view/product_list_view.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../shop_list/model/shop_model.dart';
import '../../user_change_location/view/user_change_location_view.dart';
import '../viewmodel/owner_product_list_view_model.dart';
import 'map_shop_view.dart';

part 'subview/owner_product_extension.dart';

class OwnerProductListMapView extends StatelessWidget {
  final bool isDirection;
  final ShopModel? shopModel;
  const OwnerProductListMapView({Key? key, this.isDirection = false, this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerProductListViewModel>(
      viewModel: OwnerProductListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init(isDirection: isDirection, shopModel: shopModel);
      },
      onPageBuilder: (BuildContext context, OwnerProductListViewModel viewmodel) => buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(BuildContext context, OwnerProductListViewModel viewmodel) {
    return Observer(builder: (_) {
      return Scaffold(
        key: viewmodel.scaffoldState,
        body: viewmodel.isShopMapLoading
            ? CallCircularProgress(context)
            : Stack(
                children: [
                  MapShopView(viewModel: viewmodel),
                  buildSearchTextField(context, viewmodel),
                  buildSelectUseLocationButton(context),
                ],
              ),
      );
    });
  }
}
