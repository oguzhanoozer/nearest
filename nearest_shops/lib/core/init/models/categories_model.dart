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
    Categories(categoryName: "Gift", categoryId: 1),
    Categories(categoryName: "Kitchen", categoryId: 2),
    Categories(categoryName: "Technology", categoryId: 3),
    Categories(categoryName: "Shoes", categoryId: 4),
    Categories(categoryName: "Car", categoryId: 5),
    Categories(categoryName: "Other", categoryId: 6),
  ];

  List<Categories> getListCategories() {
    return _categoriesList;
  }
}
