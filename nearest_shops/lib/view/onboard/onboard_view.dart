import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:nearest_shops/core/components/button/normal_button.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/view/authentication/onboard/view/onboard_view.dart';

import '../../core/init/lang/locale_keys.g.dart';

class OnBoardViewLottie extends StatefulWidget {
  OnBoardViewLottie({Key? key}) : super(key: key);

  @override
  State<OnBoardViewLottie> createState() => _OnBoardViewLottieState();
}

class _OnBoardViewLottieState extends State<OnBoardViewLottie> {
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
        Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.navigateToPage(OnBoardView());
              },
              child: Text(LocaleKeys.skipText.locale,
                  style: context.textTheme.headline6!.copyWith(
                      color: Color.fromARGB(255, 55, 145, 218),
                      fontWeight: FontWeight.bold)),
            )),
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
              padding: EdgeInsets.all(8),
              child: getIcon(index),
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
        onboardColumn(LocaleKeys.titleExampleText.locale,
            LocaleKeys.bodyExampleText.locale, 'asset/lottie/gift.json'),
        onboardColumn(
          LocaleKeys.titleExampleText.locale,
          LocaleKeys.bodyExampleText.locale,
          'asset/lottie/online-shopping.json',
        ),
        onboardColumn(
          LocaleKeys.titleExampleText.locale,
          LocaleKeys.bodyExampleText.locale,
          'asset/lottie/shopping.json',
        ),
      ],
    );
  }

  Widget onboardColumn(String title, String body, String path) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.emptySizedHeightBoxLow3x,
        Container(
          height: 300,
          width: 300,
          child: Lottie.asset(
            path,
            repeat: true,
            reverse: true,
            animate: true,
          ),
        ),
        context.emptySizedHeightBoxLow,
        Column(
          children: [
            Text(title),
            context.emptySizedHeightBoxLow,
            Text(body),
          ],
        ),
        context.emptySizedHeightBoxHigh,
      ],
    );
  }

  Widget getIcon(int index) {
    bool checkValid = index == currentIndex;
    double circleRadius = checkValid ? 25 : 20;
    double iconRadius = checkValid ? 30 : 20;
    Color? iconColor =
        index == currentIndex ? Colors.white : Colors.blueGrey[300];
    List<Widget> _iconList = [
      buildCircleAvatar(
          Icons.card_giftcard, circleRadius, iconRadius, iconColor),
      buildCircleAvatar(Icons.shop, circleRadius, iconRadius, iconColor),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCircleAvatar(Icons.edit_location_alt_rounded, circleRadius,
              iconRadius, iconColor),
          AnimatedCrossFade(
              duration: Duration(milliseconds: 1000),
              reverseDuration: Duration(milliseconds: 600),
              crossFadeState: checkValid
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: SizedBox(),
              secondChild: context.emptySizedWidthBoxHigh),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 1000),
            reverseDuration: Duration(milliseconds: 600),
            crossFadeState: checkValid
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: SizedBox(),
            secondChild: NormalButton(
              onPressed: () => context.navigateToPage(OnBoardView()),
              fixedSize: Size(80, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.doneText.locale,
                    style: context.textTheme.headline5!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                    size: 50,
                  ),
                ],
              ),
              color: Color.fromARGB(255, 55, 145, 218),
            ),
          ),
        ],
      ),
    ];

    return _iconList[index];
  }

  CircleAvatar buildCircleAvatar(
      IconData icon, double circleRadius, double iconRadius, Color? iconColor) {
    return CircleAvatar(
      radius: circleRadius,
      child: Icon(icon, size: iconRadius, color: iconColor),
    );
  }
}
