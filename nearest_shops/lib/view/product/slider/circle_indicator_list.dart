import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class BuildCircleIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;

  const BuildCircleIndicator({Key? key, required this.length, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.005)),
        child: CircleAvatar(
          backgroundColor: currentIndex == index
              ? context.colorScheme.onSurfaceVariant
              : context.colorScheme.onSurfaceVariant.withOpacity(0.3),
          radius: 5,
        ),
      ),
    );
  }
}
