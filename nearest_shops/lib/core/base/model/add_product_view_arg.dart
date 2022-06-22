import '../../../view/home/product_detail/model/product_detail_model.dart';

class AddProductViewArguments {
  final ProductDetailModel? productDetailModel;
  final bool isUpdate;

  AddProductViewArguments(this.productDetailModel, {this.isUpdate = false});
}
