import '../../../view/home/product_detail/model/product_detail_model.dart';

class ProductDetailViewArguments {
  final ProductDetailModel productDetailModel;
  final bool isFavourite;

  ProductDetailViewArguments(this.productDetailModel, this.isFavourite);
}
