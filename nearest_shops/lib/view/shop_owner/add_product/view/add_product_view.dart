import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/components/column/form_column.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import 'package:nearest_shops/view/shop_owner/add_product/viewmodel/add_product_view_model.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/init/models/categories_model.dart';

part 'subview/add_product_inputs_extension.dart';

// ignore: must_be_immutable
class AddProductView extends StatelessWidget {
  final ProductDetailModel? productDetailModel;
  final bool isUpdate;

  AddProductView({Key? key, this.productDetailModel, this.isUpdate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddProductViewModel>(
        viewModel: AddProductViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init(
              isUpdate: isUpdate, productDetailModel: productDetailModel);
        },
        onPageBuilder: (BuildContext context, AddProductViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Widget buildScaffold(BuildContext context, AddProductViewModel viewModel) {
    return SafeArea(
      child: Scaffold(
        key: viewModel.scaffoldState,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              context.emptySizedHeightBoxLow,
              Expanded(
                flex: 1,
                child: Text("Add new product"),
              ),
              Expanded(
                flex: 19,
                child: SingleChildScrollView(
                  child: Form(
                    key: viewModel.formState,
                    child: FormColumn(
                      children: [
                        buildNameTextField(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        buildSummaryTextField(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        buildDetailTextField(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        buildPriceTextField(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        categoriesText(context),
                        categoriesOptions(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        buildLastSeenTextField(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        buildSelectProductImageButton(viewModel, context),
                        context.emptySizedHeightBoxLow,
                        selectedImageSlider(viewModel, context),
                       /// isUpdate ? updatedImageSlider(context) : Container(),
                        buildAddProductButton(viewModel, context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesText(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Categories Options",
          style: context.textTheme.headline6!.copyWith(color: Colors.black),
        ));
  }

  Widget categoriesOptions(
      AddProductViewModel viewModel, BuildContext context) {
    List<Categories> categoriesList =
        CategoriesInitializer.instance.getListCategories();

    return Observer(builder: (_) {
      return SizedBox(
        height: context.dynamicHeight(0.05),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          scrollDirection: Axis.horizontal,
          children: categoriesList
              .map(
                (data) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: context.colorScheme.onSurfaceVariant,
                        value: data.categoryId,
                        groupValue: viewModel.returnGroupId,
                        onChanged: (index) {
                          viewModel.changeGroupId(data.categoryId);
                        }),
                    Text(
                      data.categoryName,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
    });
  }

  Widget selectedImageSlider(
      AddProductViewModel viewModel, BuildContext context) {
    return Observer(
      builder: (_) {
        return viewModel.isImageSelected
            ? CircularProgressIndicator()
            : viewModel.tempFile.isEmpty
                ? Container(
                    height: context.highValue,
                    child: CircleAvatar(
                      backgroundColor: context.colorScheme.onInverseSurface,
                      radius: 50,
                      child: Icon(Icons.shopify_sharp),
                    ),
                  )
                : Container(
                    height: context.highValue,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.tempFile.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                  ),
                                  onTap: () =>
                                      viewModel.deleteSelectedImage(index),
                                ),
                                top: 0,
                                right: 0,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(
                                    File(viewModel.tempFile[index].path)),
                                backgroundColor: Colors.transparent,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
      },
    );
  }

  Widget updatedImageSlider(BuildContext context) {
    return Container(
      height: context.highValue,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productDetailModel!.imageUrlList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  child: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  top: 0,
                  right: 0,

                  ///right: -30,
                ),
                CircleAvatar(
                  radius: 30,
                  child: Image.network(
                      productDetailModel!.imageUrlList![index].toString()),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSelectProductImageButton(
      AddProductViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
          child: Text(
            "Select product image",
            style: context.textTheme.headline6!
                .copyWith(color: context.colorScheme.onSecondary),
          ),
          onPressed: viewModel.isLoading
              ? null
              : () async {
                  await viewModel.selectImage();
                },
          color: context.appTheme.colorScheme.onSurfaceVariant,
          fixedSize: Size(context.width * 0.7, context.height * 0.06));
    });
  }

  Widget buildAddProductButton(
      AddProductViewModel viewModel, BuildContext context) {
    return Observer(
      builder: (_) {
        return viewModel.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            :  isUpdate?NormalButton(
                child: Text(
                  "Update Product",
                  style: context.textTheme.headline6!
                      .copyWith(color: context.colorScheme.onSecondary),
                ),
                onPressed: () async {
                  await viewModel.addProduct(viewModel.tempFile,isUpdate,productModel: productDetailModel! );
                },
                color: context.appTheme.colorScheme.onSurfaceVariant,
                //   fixedSize: Size(context.width * 0.7, context.height * 0.06),
              ):
            
            NormalButton(
                child: Text(
                  "Add Product",
                  style: context.textTheme.headline6!
                      .copyWith(color: context.colorScheme.onSecondary),
                ),
                onPressed: () async {
                  await viewModel.addProduct(viewModel.tempFile,isUpdate);
                },
                color: context.appTheme.colorScheme.onSurfaceVariant,
                //   fixedSize: Size(context.width * 0.7, context.height * 0.06),
              );
      },
    );
  }
}
