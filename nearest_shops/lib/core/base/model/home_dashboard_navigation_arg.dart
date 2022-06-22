import '../../../view/home/shop_list/model/shop_model.dart';

class HomeDashboardNavigationArg {
  final bool isDirection;
  final ShopModel? shopModel;

  HomeDashboardNavigationArg(this.shopModel, {this.isDirection = false});
}
