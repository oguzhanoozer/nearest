import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/view/product/input_text_decoration.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../utility/error_helper.dart';
import '../service/shop_owner_add_product_service.dart';

part 'add_product_view_model.g.dart';

class AddProductViewModel = _AddProductViewModelBase with _$AddProductViewModel;

abstract class _AddProductViewModelBase with Store, BaseViewModel, ErrorHelper {
  final GlobalKey<FormState> formState = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? productNameController;
  TextEditingController? productSummaryController;
  TextEditingController? productDetailController;
  TextEditingController? productPriceController;
  TextEditingController? productLastSeenDateController;

  late IShopOwnerAddProductService shopOwnerAddProductService;

  final ImagePicker picker = ImagePicker();

  @observable
  List<XFile> pickedFile = [];

  @observable
  ObservableList<File> tempFile = ObservableList<File>();

  @observable
  bool isLoading = false;

  @observable
  bool isImageSelected = false;

  @observable
  int _defaultCategoryId = 1;

  @observable
  String _defaultCategoryTitle = "Gift";

  @action
  void changeCategoryId(int value) {
    _defaultCategoryId = value;
  }

  @action
  void changeCategoryTitle(String value) {
    _defaultCategoryTitle = value;
  }

  int get returnCategoryId => _defaultCategoryId;

  String get returnCategoryTitle => _defaultCategoryTitle;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    shopOwnerAddProductService = ShopOwnerAddProductService(scaffoldState, context);
  }

  @override
  Future<void> init({bool? isUpdate, ProductDetailModel? productDetailModel}) async {
    productNameController = TextEditingController();
    productSummaryController = TextEditingController();
    productDetailController = TextEditingController();
    productLastSeenDateController = TextEditingController();
    productPriceController = TextEditingController();

    if (isUpdate != null && isUpdate && productDetailModel != null) {
      await showProductImage(productDetailModel.imageUrlList!);
      productNameController!.text = productDetailModel.name.toString();
      productSummaryController!.text = productDetailModel.summary.toString();
      productDetailController!.text = productDetailModel.detail.toString();
      productLastSeenDateController!.text = DateFormat('dd/MM/yyyy').format(productDetailModel.lastSeenDate!);
      productPriceController!.text = productDetailModel.price.toString();
    }
  }

  void clearTextController() {
    productNameController!.text = "";
    productSummaryController!.text = "";
    productDetailController!.text = "";
    productLastSeenDateController!.text = "";
    productPriceController!.text = "";
    tempFile.clear();
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath' + (rng.nextInt(1000)).toString() + '.png');
    Uri uri = Uri.parse(imageUrl);
    http.Response response = await http.get(uri);

    await file.writeAsBytes(response. bodyBytes);
    return file;
  }

  @action
  Future<void> showProductImage(List<String> productListImages) async {
    isImageSelectedChange();
    await Future.forEach(productListImages, (element) async {
      int _currentIndex = 0;
      File file = await urlToFile(element! as String);
      tempFile.add(file);
    });
    isImageSelectedChange();
  }

  @action
  void deleteSelectedImage(int index) {
    tempFile.removeAt(index);
  }

  @action
  Future<void> selectImage() async {
    isImageSelectedChange();

    pickedFile = await picker.pickMultiImage() ?? [];

    List<File> tempFileList = [];

    for (var filex in pickedFile) {
      tempFileList.add(File(filex.path));
    }

    tempFile.addAll(tempFileList);
    isImageSelectedChange();
  }

  @action
  Future<void> addProduct(List<File> pickedFile, bool isUpdate, {ProductDetailModel? productModel}) async {
    isLoadingChange();

    try {
      String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState, context!);

      if (shopId != null) {
        if (formState.currentState!.validate()) {
          String productId = isUpdate ? productModel!.productId! : DateTime.now().millisecondsSinceEpoch.toString();

          if (isUpdate) {
            await removeOldImage(productModel!.imageStoreNameList!, productModel.productId.toString());
            ProductDetailModel productData = await createProductModel(pickedFile: pickedFile, productId: productId, shopId: shopId);

            await shopOwnerAddProductService.updateProduct(productData);

            showSnackBar(scaffoldState, context!, LocaleKeys.updateProductIsSuccesfull.locale);
            Navigator.pop(context!, productData);
          } else {
            ProductDetailModel productData = await createProductModel(pickedFile: pickedFile, productId: productId, shopId: shopId);
            await shopOwnerAddProductService.addProduct(productData);
            clearTextController();
            showSnackBar(scaffoldState, context!, LocaleKeys.addProductIsSuccesfull.locale);
          }
        }
      }
    } catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.addProductError.locale);

      isLoadingChange();
    }

    isLoadingChange();
  }

  Future<ProductDetailModel> createProductModel({required List<File> pickedFile, required String productId, required String shopId}) async {
    List<String> imageList = await shopOwnerAddProductService.uploadImage(pickedFile, productId);
    ProductDetailModel productData = ProductDetailModel(
        name: productNameController!.text,
        detail: productDetailController!.text,
        summary: productSummaryController!.text,
        price: double.parse(productPriceController!.text),
        productId: productId,
        shopId: shopId,
        lastSeenDate: DateFormat('d/M/y').parse(productLastSeenDateController!.text),
        imageUrlList: imageList,
        categoryId: returnCategoryId,
        categoryTitle: returnCategoryTitle,
        imageStoreNameList: shopOwnerAddProductService.imageStoreNameList);
    return productData;
  }

  Future<void> removeOldImage(List<String> imageUrlList, String productId) async {
    // await Future.wait(imageUrlList.map((e) async {
    User? user = FirebaseAuthentication.instance.authCurrentUser();
    if (user != null) {
      await FirebaseStorageInitalize.instance.firabaseStorage.ref("${ContentString.CONTENT.rawValue}/${user.uid}/${productId}").listAll().then((value) {
        value.items.forEach((element) {
          FirebaseStorageInitalize.instance.firabaseStorage.ref(element.fullPath).delete();
        });
      });
    }

    ///   }));
  }

  @action
  void isImageSelectedChange() {
    isImageSelected = !isImageSelected;
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }
}
