part of '../dashboard_view.dart';

extension _DashboardProductsWidgets on DashboardView {


  Widget buildCategoriesRow(
      BuildContext context, DashboardViewModel viewModel) {
    List<Widget> categoriesItem = [
      buildCategoryContainer(
          context, "All", ImagePaths.instance.technology, viewModel, 0),
      buildCategoryContainer(
          context, "Gift", ImagePaths.instance.gift, viewModel, 1),
      buildCategoryContainer(
          context, "Kitchen", ImagePaths.instance.kitchen, viewModel, 2),
      buildCategoryContainer(
          context, "Technology", ImagePaths.instance.technology, viewModel, 3),
      buildCategoryContainer(
          context, "Shoes", ImagePaths.instance.shoes, viewModel, 4),
      buildCategoryContainer(
          context, "Cars", ImagePaths.instance.cars, viewModel, 5),
      buildCategoryContainer(
          context, "Other", ImagePaths.instance.gift, viewModel, 6)
    ];

    return Observer(builder: (_) {
      return SizedBox(
        height: context.dynamicHeight(0.05),
        child: ListView(
            // shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: categoriesItem),
      );
    });

  }

  Widget buildCategoryContainer(BuildContext context, String title,
      String iconUrl, DashboardViewModel viewModel, int categoryId) {
    return GestureDetector(
      onTap: () {
        viewModel.changeCategoryId(categoryId);
      },
      child: Padding(
        padding: EdgeInsets.only(right: context.lowValue),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: context.colorScheme.onInverseSurface, width: 0.5),
            borderRadius: BorderRadius.circular(context.normalValue),
          ),
          color: viewModel.categoryId == categoryId
              ? Colors.grey[200]
              : Colors.white,
          child: Padding(
            padding: context.paddingLow,
            child: Row(
              children: [
                Center(
                  child: Image.asset(
                    iconUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                context.emptySizedWidthBoxLow,
                Text(
                  title,
                  style: context.textTheme.bodyText2!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
      hintText: "Search product",
      suffixIcon: Icon(
        Icons.filter_list_outlined,
        size: 30,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
