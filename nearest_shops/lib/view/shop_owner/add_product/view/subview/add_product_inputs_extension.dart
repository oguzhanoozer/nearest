part of '../add_product_view.dart';

extension _AddProductTextFieldsExtension on AddProductView {
  TextFormField buildNameTextField(AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterProductNameText.locale,
        keyboardType: TextInputType.name,
        controller: viewModel.productNameController,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.productNameText.locale, prefixIcon: Icons.shopping_bag_outlined, prefixIconColor: context.colorScheme.primary));
  }

  TextFormField buildSummaryTextField(AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterProductSummaryText.locale,
        keyboardType: TextInputType.name,
        controller: viewModel.productSummaryController,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.productSummaryText.locale, prefixIcon: Icons.shopping_cart_outlined, prefixIconColor: context.colorScheme.primary));
  }

  TextFormField buildDetailTextField(AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        maxLines: 5,
        textAlignVertical: TextAlignVertical.center,
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterProductDetailText.locale,
        keyboardType: TextInputType.name,
        controller: viewModel.productDetailController,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.productDetailText.locale, prefixIcon: Icons.shopping_basket_outlined, prefixIconColor: context.colorScheme.primary));
  }

  TextFormField buildPriceTextField(AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: inputTextStyle(context),
      validator: (value) => value!.isNotEmpty && double.tryParse(value) != null ? null : LocaleKeys.enterProductPriceText.locale,
      keyboardType: TextInputType.number,
      controller: viewModel.productPriceController,
      decoration: buildInputDecoration(context,
          hintText: LocaleKeys.productPriceText.locale, prefixIcon: Icons.price_change_outlined, prefixIconColor: context.colorScheme.primary),
    );
  }

  TextFormField buildLastSeenTextField(AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: inputTextStyle(context),
      onTap: () async {
        var dateTime = await showDatePicker(
          builder: (context, child) {
            return Theme(
                data: context.watch<ThemeManager>().currentThemeData.copyWith(
                      colorScheme: ColorScheme.dark(
                        onPrimary: context.colorScheme.onSurfaceVariant,
                        primary: context.colorScheme.inversePrimary,
                        surface: context.colorScheme.onSurfaceVariant,
                        onSurface: context.colorScheme.inversePrimary,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: context.colorScheme.inversePrimary,
                          backgroundColor: context.colorScheme.onSurfaceVariant,
                          textStyle: GoogleFonts.lora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      dialogBackgroundColor: context.colorScheme.onSurfaceVariant,
                    ),
                child: child!);
          },
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (dateTime != null) {
          viewModel.productLastSeenDateController!.text = DateFormat('dd/MM/yyyy').format(dateTime);
        }
      },
      validator: (value) => value!.isNotEmpty ? null : LocaleKeys.selectProductLastSeenDateText.locale,
      keyboardType: TextInputType.datetime,
      controller: viewModel.productLastSeenDateController,
      decoration: buildInputDecoration(context,
          hintText: LocaleKeys.productLastSeenExample.locale, prefixIcon: Icons.date_range_outlined, prefixIconColor: context.colorScheme.primary),
    );
  }
}
