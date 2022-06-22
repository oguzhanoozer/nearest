import '../../../core/extension/string_extension.dart';

class ImagePaths {
  static ImagePaths? _instance;
  static ImagePaths get instance {
    return _instance ??= ImagePaths._init();
  }

  ImagePaths._init();

  final hotDog = "hotdog".toImagePath;
  final profile = "profile".toImagePath;
  final prof = "prof2".toImagePath;
  final grape = "grape".toImagePath;
  final hazelnut = "hazelnut".toImagePath;
  final tulip = "tulip".toImagePath;
  final turnip = "turnip".toImagePath;
  final currant = "currant".toImagePath;
  final kiwi = "kiwi".toImagePath;

  final icons_all = "icons_all".toImagePath;
  final icons_gift = "icons_gift".toImagePath;
  final icons_kitchen = "icons_kitchen".toImagePath;
  final icons_technology = "icons_technology".toImagePath;
  final icons_shoes = "icons_shoes".toImagePath;
  final icons_cars = "icons_cars".toImagePath;
  final icons_other = "icons_other".toImagePath;
  final icons_kit = "icons_kit".toImagePath;
  final filter_512 = "filter512".toImagePath;
  final filter256 = "filter256".toImagePath;
  final filter64 = "filter64".toImagePath;
  final filter16 = "filter16".toImagePath;
  final filter_white_256 = "filter_white_256".toImagePath;
  final filter_white_512 = "filter_white_512".toImagePath;
  final filter_white_128 = "filter_white_128".toImagePath;
  final filter_white2 = "filter_white2".toImagePath;

  final facebookSVG = "facebook".toSVG;
  final googleSVG = "google".toSVG;
  final localization1SVG = "localization1".toSVG;
  final localization2SVG = "localization2".toSVG;
  final localization3SVG = "localization3".toSVG;
  final filter_white2Svg = "filter_white2".toSVG;

  final loti_1 = "loti_1".toLottiePath;
  final loti_3 = "loti_3".toLottiePath;
  final loti_8 = "loti_8".toLottiePath;
  final loti_16 = "loti_16".toLottiePath;
  final loti_17 = "loti_17".toLottiePath;
  final shop_lottie = "shop_lottie".toLottiePath;
  final shop_lottie2 = "shop_lottie2".toLottiePath;
  final shop_lottie3 = "shop_lottie3".toLottiePath;

  final gift = "gift".toLottiePath;
  final shopping = "shopping".toLottiePath;
}

List<String> staticImageUrlList = [
  ImagePaths.instance.icons_all,
  ImagePaths.instance.icons_gift,
  ImagePaths.instance.icons_kitchen,
  ImagePaths.instance.icons_technology,
  ImagePaths.instance.icons_shoes,
  ImagePaths.instance.icons_cars,
  ImagePaths.instance.icons_other
];

