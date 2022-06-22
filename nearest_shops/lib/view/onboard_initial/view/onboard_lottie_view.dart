import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../core/components/button/normal_button.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../authentication/onboard/view/onboard_view.dart';
import '../../product/contstants/image_path.dart';

class OnBoardLottieView extends StatefulWidget {
  OnBoardLottieView({Key? key}) : super(key: key);

  @override
  State<OnBoardLottieView> createState() => _OnBoardLottieViewState();
}

class _OnBoardLottieViewState extends State<OnBoardLottieView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: context.paddingNormal,
        child: builderBoardColumn(context),
      )),
    );
  }

  Column builderBoardColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LocaleKeys.TheNearestBigTitle.locale,
                style: GoogleFonts.concertOne(
                    textStyle: context.textTheme.headline4!.copyWith(color: context.appTheme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold))),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, onBoardViewRoute);
              },
              child: Text(
                LocaleKeys.skipText.locale,
                style: GoogleFonts.concertOne(
                    textStyle: context.textTheme.headline6!.copyWith(color: context.appTheme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 17,
          child: builderPageView(),
        ),
        Expanded(
          flex: 3,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: context.paddingLow,
              child: getIcon(index, context),
            ),
          ),
        ),
      ],
    );
  }

  PageView builderPageView() {
    return PageView(
      onPageChanged: (value) {
        currentIndex = value;
        setState(() {});
      },
      children: [
        onboardColumn(
          LocaleKeys.lottieTitle1.locale,
          LocaleKeys.lottieBody1.locale,
          ImagePaths.instance.gift,
        ),
        onboardColumn(
          LocaleKeys.lottieTitle2.locale,
          LocaleKeys.lottieBody2.locale,
          ImagePaths.instance.shopping,
        ),
        onboardColumn(
          LocaleKeys.lottieTitle3.locale,
          LocaleKeys.lottieBody3.locale,
          ImagePaths.instance.loti_3,
        ),
      ],
    );
  }

  Widget onboardColumn(String title, String body, String path) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.emptySizedHeightBoxLow3x,
        SizedBox(
          height: context.dynamicHeight(0.3),
          width: context.dynamicWidth(0.9),
          child: Lottie.asset(
            path,
            repeat: true,
            reverse: true,
            animate: true,
          ),
        ),
        context.emptySizedHeightBoxLow,
        Padding(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
              Text(title,
                  style:
                      GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 67, 124, 73)))),
              context.emptySizedHeightBoxLow,

              /// Text(body, style: GoogleFonts.lora(textStyle: context.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w100))),
            ],
          ),
        ),
        context.emptySizedHeightBoxHigh,
      ],
    );
  }

  Widget getIcon(int index, BuildContext context) {
    bool checkValid = index == currentIndex;
    double circleRadius = checkValid ? context.dynamicHeight(0.030) : context.dynamicHeight(0.02);
    double iconRadius = checkValid ? context.dynamicHeight(0.04) : context.dynamicHeight(0.02);
    Color? iconColor = index == currentIndex ? context.colorScheme.onSecondary : context.colorScheme.onSecondary.withOpacity(0.5);
    List<Widget> _iconList = [
      buildCircleAvatar(context, Icons.card_giftcard, circleRadius, iconRadius, iconColor),
      buildCircleAvatar(context, Icons.edit_location_alt_rounded, circleRadius, iconRadius, iconColor),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCircleAvatar(context, Icons.shop, circleRadius, iconRadius, iconColor),
          AnimatedCrossFade(
              duration: context.durationNormal,
              reverseDuration: context.durationLow,
              crossFadeState: checkValid ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              firstChild: const SizedBox(),
              secondChild: context.emptySizedWidthBoxHigh),
          AnimatedCrossFade(
            duration: context.durationNormal,
            reverseDuration: context.durationLow,
            crossFadeState: checkValid ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(),
            secondChild: NormalButton(
              onPressed: () => Navigator.pushReplacementNamed(context, onBoardViewRoute),
              fixedSize: Size(context.dynamicWidth(0.2), context.dynamicHeight(0.05)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.doneText.locale,
                    style: GoogleFonts.lora(
                        textStyle: context.textTheme.headline3!.copyWith(color: context.appTheme.colorScheme.onSecondary, fontWeight: FontWeight.bold)),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: context.colorScheme.onSecondary,
                    size: context.highValue,
                  ),
                ],
              ),
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ];

    return _iconList[index];
  }

  CircleAvatar buildCircleAvatar(BuildContext context, IconData icon, double circleRadius, double iconRadius, Color? iconColor) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.onSurfaceVariant,
      radius: circleRadius,
      child: Icon(icon, size: iconRadius, color: iconColor),
    );
  }
}
