import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/add_product_view_arg.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/models/categories_model.dart';
import '../../../../core/init/theme/app_theme.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';
import '../viewmodel/add_product_view_model.dart';

part 'subview/add_product_inputs_extension.dart';

// ignore: must_be_immutable
class AddProductView extends StatelessWidget {
  final AddProductViewArguments addProductViewArguments;

  AddProductView({Key? key, required this.addProductViewArguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddProductViewModel>(
        viewModel: AddProductViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init(isUpdate: addProductViewArguments.isUpdate, productDetailModel: addProductViewArguments.productDetailModel);
        },
        onPageBuilder: (BuildContext context, AddProductViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Widget buildScaffold(BuildContext context, AddProductViewModel viewModel) {
    return SafeArea(
      child: Scaffold(
        key: viewModel.scaffoldState,
        appBar: buildAppBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              context.emptySizedHeightBoxLow,
              Expanded(
                flex: 19,
                child: SingleChildScrollView(
                  child: Form(
                    key: viewModel.formState,
                    child: FormColumn(
                      children: [
                        context.emptySizedHeightBoxLow,
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
                        context.emptySizedHeightBoxLow3x,
                        selectedImageSlider(viewModel, context),
                        context.emptySizedHeightBoxLow3x,
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(LocaleKeys.addNewProductText.locale,
          style: GoogleFonts.concertOne(
              textStyle: context.textTheme.headline5!.copyWith(
            color: context.appTheme.colorScheme.onSurfaceVariant,
          ))),
      automaticallyImplyLeading: false,
    );
  }

  Widget categoriesText(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          LocaleKeys.categoriesOptionsText.locale,
          style: GoogleFonts.lora(textStyle: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.bold)),
        ));
  }

  Widget categoriesOptions(AddProductViewModel viewModel, BuildContext context) {
    List<Categories> categoriesList = CategoriesInitializer.instance.getListCategories();

    return Observer(builder: (_) {
      return SizedBox(
        height: context.dynamicHeight(0.05),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: categoriesList
              .map(
                (data) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: context.colorScheme.primary,
                        value: data.categoryId,
                        groupValue: viewModel.returnCategoryId,
                        onChanged: (index) {
                          viewModel.changeCategoryId(data.categoryId);
                          viewModel.changeCategoryTitle(data.categoryName);
                        }),
                    Text(
                      data.categoryName,
                      style: GoogleFonts.lora(textStyle: context.textTheme.bodyMedium!.copyWith(color: context.colorScheme.primary)),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
    });
  }

  Widget selectedImageSlider(AddProductViewModel viewModel, BuildContext context) {
    return Observer(
      builder: (_) {
        return viewModel.isImageSelected
            ? CallCircularProgress(context)
            : viewModel.tempFile.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: context.highValue * 1.2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.tempFile.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Stack(
                            children: [
                              buildImage(viewModel.tempFile[index].path, context),
                              Positioned(
                                bottom: 0,
                                right: context.dynamicHeight(0.01),
                                child: buildEditIcon(viewModel, index, context),
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

  Widget buildImage(String imageUrl, BuildContext context) {
    // final image = Image.file(
    //   File(imageUrl),
    //   fit: BoxFit.fill,
    //   height: context.dynamicHeight(0.15),
    //   width: context.dynamicHeight(0.15),
    // );

    return CircleAvatar(
      radius: context.dynamicHeight(0.2) / 3,
      backgroundImage: Image.file(
        File(imageUrl),
        height: context.highValue,
        width: context.highValue,
        fit: BoxFit.fill,
      ).image,
    );
  }

  Widget buildEditIcon(AddProductViewModel viewModel, int index, BuildContext context) => GestureDetector(
      child: CircleAvatar(
          child: Icon(Icons.close, color: context.colorScheme.inversePrimary),
          radius: context.normalValue,
          backgroundColor: context.colorScheme.onSurfaceVariant),
      onTap: () {
        viewModel.deleteSelectedImage(index);
      });
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }

  Widget buildSelectProductImageButton(AddProductViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NormalButton(
            child: Text(
              LocaleKeys.selectProductImageText.locale,
              style: GoogleFonts.lora(textStyle: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.inversePrimary)),
            ),
            onPressed: viewModel.isLoading
                ? null
                : () async {
                    await viewModel.selectImage();
                  },
            color: context.appTheme.colorScheme.onSurfaceVariant,
            fixedSize: Size(context.width * 0.5, context.height * 0.06),
          ),
        ],
      );
    });
  }

  Widget buildAddProductButton(AddProductViewModel viewModel, BuildContext context) {
    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            viewModel.isLoading
                ? CallCircularProgress(context)
                : addProductViewArguments.isUpdate
                    ? NormalButton(
                        child: Text(
                          LocaleKeys.updateProductText.locale,
                          style: GoogleFonts.lora(textStyle: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.inversePrimary)),
                        ),
                        onPressed: () async {
                          await viewModel.addProduct(viewModel.tempFile, addProductViewArguments.isUpdate,
                              productModel: addProductViewArguments.productDetailModel!);
                        },
                        color: context.appTheme.colorScheme.onSurfaceVariant,
                        fixedSize: Size(context.width * 0.5, context.height * 0.06),
                      )
                    : NormalButton(
                        child: Text(
                          LocaleKeys.addNewProductText.locale,
                          style: GoogleFonts.lora(textStyle: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.inversePrimary)),
                        ),
                        onPressed: () async {
                          await viewModel.addProduct(viewModel.tempFile, addProductViewArguments.isUpdate);
                        },
                        color: context.appTheme.colorScheme.onSurfaceVariant,
                        fixedSize: Size(context.width * 0.5, context.height * 0.06),
                      ),
          ],
        );
      },
    );
  }
}
