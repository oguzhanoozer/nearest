import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:nearest_shops/view/product/input_text_decoration.dart';

import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../circular_progress/circular_progress_indicator.dart';
import '../contstants/image_path.dart';

Image buildImageNetwork(String imageUrl, BuildContext context, {double height = double.infinity, double width = double.infinity}) {
  return Image.network(
    imageUrl,
    fit: BoxFit.fill,
    height: height,
    width: width,
    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      return child;
    },
    loadingBuilder: (context, child, loadingProgress) {
      final totalBytes = loadingProgress?.expectedTotalBytes;
      final bytesLoaded = loadingProgress?.cumulativeBytesLoaded;
      if (totalBytes != null && bytesLoaded != null) {
        return Padding(
          padding: context.paddingLow,
          child: CallCircularProgress(context),
        );
      } else {
        return child;
      }
    },
    errorBuilder: (context, error, stackTrace) {
      return Center(child: Text(LocaleKeys.errorText.locale, style: priceTextStyle(context)));
    },
  );
}

Widget shopDefaultLottie(BuildContext context) {
  return Padding(
    padding: context.paddingLow,
    child: Lottie.asset(
      ImagePaths.instance.shop_lottie3,
      repeat: true,
      reverse: true,
      animate: true,
    ),
  );
}

Widget defaultProductImage(BuildContext context, int categoryId) {
  return Image.asset(
    staticImageUrlList[categoryId],
    color: context.colorScheme.background,
    fit: BoxFit.fill,
  );
}
