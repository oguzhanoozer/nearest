import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class BuildCircleIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;
  final bool isDetailPage;

  const BuildCircleIndicator({Key? key, required this.length, required this.currentIndex, this.isDetailPage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: context.dynamicWidth(0.005)),
        child: CircleAvatar(
          backgroundColor: currentIndex == index
              ? isDetailPage
                  ? context.colorScheme.onSecondary
                  : context.colorScheme.onSurfaceVariant
              : isDetailPage
                  ? context.colorScheme.onSecondary.withOpacity(0.5)
                  : context.colorScheme.onSurfaceVariant.withOpacity(0.3),
          radius: isDetailPage ? context.lowValue * 0.7 : context.lowValue * 0.7,
        ),
      ),
    );
  }
}
