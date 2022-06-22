import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

Widget CallCircularProgress(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      color: context.colorScheme.onSurfaceVariant,
    ),
  );
}
