import '../../extension/string_extension.dart';
import '../lang/locale_keys.g.dart';

class Categories {
  String categoryName;
  int categoryId;

  Categories({required this.categoryName, required this.categoryId});
}

class CategoriesInitializer {
  static CategoriesInitializer _instance = CategoriesInitializer._init();
  CategoriesInitializer._init();
  static CategoriesInitializer get instance => _instance;

  final List<Categories> _categoriesList = [
    Categories(categoryName: LocaleKeys.giftText.locale, categoryId: 1),
    Categories(categoryName: LocaleKeys.kitchenText.locale, categoryId: 2),
    Categories(categoryName: LocaleKeys.technologyText.locale, categoryId: 3),
    Categories(categoryName: LocaleKeys.shoesText.locale, categoryId: 4),
    Categories(categoryName: LocaleKeys.carsText.locale, categoryId: 5),
    Categories(categoryName: LocaleKeys.otherText.locale, categoryId: 6),
  ];

  List<Categories> getListCategories() {
    return _categoriesList;
  }
}
