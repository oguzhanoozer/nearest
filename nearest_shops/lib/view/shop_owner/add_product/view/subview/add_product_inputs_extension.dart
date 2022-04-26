part of '../add_product_view.dart';

extension _AddProductTextFieldsExtension on AddProductView {
  TextFormField buildNameTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterProductNameText.locale,
      keyboardType: TextInputType.name,
      controller: viewModel.productNameController,
      decoration: buildNameTextFieldDecoration(context),
    );
  }

  InputDecoration buildNameTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.productNameText.locale),
        icon: buildContainerIconField(context, Icons.business_sharp),
        hintText: LocaleKeys.productNameText.locale);
  }

  TextFormField buildSummaryTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterProductSummaryText.locale,
      keyboardType: TextInputType.name,
      controller: viewModel.productSummaryController,
      decoration: buildSummaryTextFieldDecoration(context),
    );
  }

  InputDecoration buildSummaryTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.productSummaryText.locale),
        icon: buildContainerIconField(context, Icons.summarize),
        hintText: LocaleKeys.productSummaryText.locale);
  }

  TextFormField buildDetailTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      maxLines: 3,
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterProductDetailText.locale,
      keyboardType: TextInputType.name,
      controller: viewModel.productDetailController,
      decoration: buildDetailTextFieldDecoration(context),
    );
  }

  InputDecoration buildDetailTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.productDetailText.locale),
        icon: buildContainerIconField(context, Icons.details),
        hintText: LocaleKeys.productDetailText.locale);
  }

  TextFormField buildPriceTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isNotEmpty && double.tryParse(value) != null
          ? null
          : LocaleKeys.enterProductPriceText.locale,
      keyboardType: TextInputType.number,
      controller: viewModel.productPriceController,
      decoration: buildPriceTextFieldDecoration(context),
    );
  }

  InputDecoration buildPriceTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.productPriceText.locale),
        icon: buildContainerIconField(context, Icons.price_change),
        hintText: LocaleKeys.productPriceText.locale);
  }

  TextFormField buildLastSeenTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      onTap: () async {
        var dateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (dateTime != null) {
          viewModel.productLastSeenDateController!.text =
              DateFormat('dd/mm/yyyy').format(dateTime);
        }
      },
      validator: (value) => value!.isNotEmpty
          ? null
          : LocaleKeys.selectProductLastSeenDateText.locale,
      keyboardType: TextInputType.datetime,
      controller: viewModel.productLastSeenDateController,
      decoration: buildLastSeenTextFieldDecoration(context),
    );
  }

  InputDecoration buildLastSeenTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.productLastSeenDateText.locale),
        icon: buildContainerIconField(context, Icons.date_range),
        hintText: LocaleKeys.productLastSeenDateText.locale);
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
