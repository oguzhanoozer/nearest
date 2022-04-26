part of '../categories_view.dart';

extension _CategoriesProductsWidgets on CategoriesView {
  Widget buildCategoriesRow(
      BuildContext context, CategoriesViewModel viewModel) {
    List<Widget> categoriesItem = [
      buildCategoryContainer(context, LocaleKeys.allText.locale,
          ImagePaths.instance.technology, viewModel, 0),
      buildCategoryContainer(context, LocaleKeys.giftText.locale,
          ImagePaths.instance.gift, viewModel, 1),
      buildCategoryContainer(context, LocaleKeys.kitchenText.locale,
          ImagePaths.instance.kitchen, viewModel, 2),
      buildCategoryContainer(context, LocaleKeys.technologyText.locale,
          ImagePaths.instance.technology, viewModel, 3),
      buildCategoryContainer(context, LocaleKeys.shoesText.locale,
          ImagePaths.instance.shoes, viewModel, 4),
      buildCategoryContainer(context, LocaleKeys.carsText.locale,
          ImagePaths.instance.cars, viewModel, 5),
      buildCategoryContainer(context, LocaleKeys.otherText.locale,
          ImagePaths.instance.gift, viewModel, 6)
    ];

    return Observer(builder: (_) {
      return SizedBox(
        height: context.dynamicHeight(0.06),
        child: ListView(
            // shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: categoriesItem),
      );
    });
  }

  Widget buildCategoryContainer(BuildContext context, String title,
      String iconUrl, CategoriesViewModel viewModel, int categoryId) {
    return GestureDetector(
        onTap: () {
          viewModel.changeCategoryId(categoryId);
        },
        child: Padding(
          padding: EdgeInsets.only(right: context.lowValue),
          child: ListItemCard(
            radius: context.normalValue,
            elevation: 0,
            color: viewModel.categoryId == categoryId
                ? context.colorScheme.surface.withOpacity(0.1)
                : context.colorScheme.onSecondary,
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
                        .copyWith(color: context.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
