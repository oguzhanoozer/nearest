part of '../owner_product_list_view.dart';

extension _Owner_product_extension on OwnerProductListView {
  Positioned buildSearchTextField(BuildContext context) {
    return Positioned(
      top: context.dynamicHeight(0.03),
      right: context.dynamicHeight(0.03),
      left: context.dynamicHeight(0.03),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        validator: (value) => null,
        obscureText: false,
        decoration: buildTextFormFieldsDecoration(context),
      ),
    );
  }

  InputDecoration buildTextFormFieldsDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: context.colorScheme.onSecondary,
      contentPadding: EdgeInsets.zero,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.5,
          color: context.colorScheme.surface.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      prefixIcon: Icon(Icons.search,
          color: context.colorScheme.surface, size: context.normalValue),
      hintStyle: context.textTheme.titleMedium!
          .copyWith(color: context.colorScheme.surface),
      hintText: "Search product",
      suffixIcon: Icon(
        Icons.filter_list_outlined,
        size: context.dynamicHeight(0.03),
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
