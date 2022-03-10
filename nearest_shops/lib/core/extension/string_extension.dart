import 'package:easy_localization/easy_localization.dart';

import '../constants/application_constants.dart';

extension StringEmailExtension on String {
  String get locale => this.tr();
  bool get emailsIsValid =>
      RegExp(ApplicationConstants.EMAIL_REGIEX).hasMatch(this);
}

extension ImageSVGPathExtension on String {
  String get toSVG => "asset/svg/$this.svg";
}

extension ImagePathExtension on String{
  String get toImagePath => "asset/image/$this.png";
}