part of '../add_product_view.dart';

extension _AddProductTextFieldsExtension on AddProductView {
  TextFormField buildNameTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isNotEmpty ? null : "Enter product name",
      keyboardType: TextInputType.name,
      controller: viewModel.productNameController,
      decoration: buildNameTextFieldDecoration(context),
    );
  }

  InputDecoration buildNameTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Product Name"),
        icon: buildContainerIconField(context, Icons.business_sharp),
        hintText: "Product Name");
  }

  TextFormField buildSummaryTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isNotEmpty ? null : "Enter product summary",
      keyboardType: TextInputType.name,
      controller: viewModel.productSummaryController,
      decoration: buildSummaryTextFieldDecoration(context),
    );
  }

  InputDecoration buildSummaryTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Product Summary"),
        icon: buildContainerIconField(context, Icons.summarize),
        hintText: "Product Summary");
  }

  TextFormField buildDetailTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      maxLines: 3,
      validator: (value) => value!.isNotEmpty ? null : "Enter product detail",
      keyboardType: TextInputType.name,
      controller: viewModel.productDetailController,
      decoration: buildDetailTextFieldDecoration(context),
    );
  }

  InputDecoration buildDetailTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Product Detail"),
        icon: buildContainerIconField(context, Icons.details),
        hintText: "Product Detail");
  }

  TextFormField buildPriceTextField(
      AddProductViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isNotEmpty && double.tryParse(value)!=null ? null : "Enter product price",
      keyboardType: TextInputType.number,
      controller: viewModel.productPriceController,
      decoration: buildPriceTextFieldDecoration(context),
    );
  }

  InputDecoration buildPriceTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Product Price"),
        icon: buildContainerIconField(context, Icons.price_change),
        hintText: "Product Price");
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
              DateFormat('dd/MM/yyyy').format(dateTime);
        }
      },
      validator: (value) =>
          value!.isNotEmpty ? null : "Select product last seen date",
      keyboardType: TextInputType.datetime,
      controller: viewModel.productLastSeenDateController,
      decoration: buildLastSeenTextFieldDecoration(context),
    );
  }

  InputDecoration buildLastSeenTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Product last seen date"),
        icon: buildContainerIconField(context, Icons.date_range),
        hintText: "Product last seen date");
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
