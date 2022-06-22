part of '../categories_view.dart';

extension _CategoriesProductsWidgets on CategoriesView {
  Widget buildCategoriesRow(BuildContext context, CategoriesViewModel viewModel) {
    List<Widget> categoriesItem = [
      buildCategoryContainer(context, LocaleKeys.allText.locale, ImagePaths.instance.icons_all, viewModel, 0),
      buildCategoryContainer(context, LocaleKeys.giftText.locale, ImagePaths.instance.icons_gift, viewModel, 1),
      buildCategoryContainer(context, LocaleKeys.kitchenText.locale, ImagePaths.instance.icons_kitchen, viewModel, 2),
      buildCategoryContainer(context, LocaleKeys.technologyText.locale, ImagePaths.instance.icons_technology, viewModel, 3),
      buildCategoryContainer(context, LocaleKeys.shoesText.locale, ImagePaths.instance.icons_shoes, viewModel, 4),
      buildCategoryContainer(context, LocaleKeys.carsText.locale, ImagePaths.instance.icons_cars, viewModel, 5),
      buildCategoryContainer(context, LocaleKeys.otherText.locale, ImagePaths.instance.icons_other, viewModel, 6)
    ];

    return Observer(builder: (_) {
      return SizedBox(
        height: context.dynamicHeight(0.05),
        child: ListView(padding: EdgeInsets.zero, scrollDirection: Axis.horizontal, children: categoriesItem),
      );
    });
  }

  Widget buildCategoryContainer(BuildContext context, String title, String iconUrl, CategoriesViewModel viewModel, int categoryId) {
    bool tempTapBool = viewModel.categoryId == categoryId ? true : false;
    return GestureDetector(
        onTap: () {
          viewModel.changeCategoryId(categoryId);
        },
        child: Padding(
          padding: EdgeInsets.only(right: context.lowValue * 2),
          child: ListItemCard(
            radius: context.normalValue,
            elevation: 0,
            color: tempTapBool ? context.colorScheme.onSurfaceVariant : context.colorScheme.onSecondary,
            child: Padding(
              padding: EdgeInsets.only(bottom: context.lowValue / 2, right: context.normalValue, top: context.lowValue / 2, left: context.lowValue / 2),
              child: Row(
                children: [
                  Padding(
                    padding: context.paddingLow / 2,
                    child: Center(
                      child: Image.asset(
                        iconUrl,
                        color: tempTapBool ? context.colorScheme.inversePrimary : context.colorScheme.onSurfaceVariant,
                        fit: BoxFit.fill,
                        height: context.dynamicHeight(0.04),
                      ),
                    ),
                  ),
                  context.emptySizedWidthBoxNormal,
                  Text(
                    title,
                    style: GoogleFonts.lora(
                        textStyle: context.textTheme.bodyText2!.copyWith(
                            fontWeight: tempTapBool ? FontWeight.w600 : FontWeight.w300,
                            color: tempTapBool ? context.colorScheme.inversePrimary : context.colorScheme.onSurfaceVariant)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
