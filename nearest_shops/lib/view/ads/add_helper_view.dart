import 'dart:io';

class AddHelperView {
  static String get bannerAddUnitId {
    if (Platform.isAndroid) {
      return "";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
  static String get interstitialAddUnitId {
    if (Platform.isAndroid) {
      return "";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
}
 