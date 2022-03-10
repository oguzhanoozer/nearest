import 'package:mobx/mobx.dart';

import '../../../product/contstants/image_path.dart';
import '../../dashboard/model/dashboard_model.dart';

part 'owner_product_list_view_model.g.dart';

class OwnerProductListViewModel = _OwnerProductListViewModelBase
    with _$OwnerProductListViewModel;

abstract class _OwnerProductListViewModelBase with Store {
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
    ),
    DashboardModel(
      url: ImagePaths.instance.turnip,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.turnip,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.turnip,
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
