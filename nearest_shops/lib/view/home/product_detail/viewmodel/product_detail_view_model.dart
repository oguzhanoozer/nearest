import 'package:mobx/mobx.dart';

import '../../../product/contstants/image_path.dart';
import '../../dashboard/model/dashboard_model.dart';

part 'product_detail_view_model.g.dart';

class ProductDetailViewModel = _ProductDetailViewModelBase
    with _$ProductDetailViewModel;

abstract class _ProductDetailViewModelBase with Store {
  List<DashboardModel> dashboardModelList = [
    DashboardModel(
      url: ImagePaths.instance.hotDog,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.kiwi,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.tulip,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.currant,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.turnip,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    )
  ];
}
