part of '../dashboard_view.dart';

extension _DashboardProductsWidgets on DashboardView {
  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: context.colorScheme.surface.withOpacity(0.05),
      contentPadding: EdgeInsets.zero,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.5, 
          color: context.colorScheme.surface.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(15),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(15),
      ),
      prefixIcon:
          Icon(Icons.search, color: context.colorScheme.surface, size: 20),
      hintStyle: TextStyle(fontSize: 15, color: context.colorScheme.surface),
      hintText: LocaleKeys.searchTheProductText.locale,
      suffixIcon: Icon(
        Icons.filter_list_outlined,
        size: 30,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
