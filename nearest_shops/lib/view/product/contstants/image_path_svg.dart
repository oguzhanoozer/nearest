import '../../../core/extension/string_extension.dart';

class SVGIMagePaths {
  static SVGIMagePaths? _instance;
  static SVGIMagePaths get instance {
    return _instance ??= SVGIMagePaths._init();
  }

  SVGIMagePaths._init();

  final facebookSVG = "facebook".toSVG;
  final googleSVG = "google".toSVG;
  final localization1SVG = "localization1".toSVG;
  final localization2SVG = "localization2".toSVG;
  final localization3SVG = "localization3".toSVG;
  //final google2SVG = "google2".toSVG;
}
