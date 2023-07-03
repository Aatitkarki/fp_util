import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fp_util/src/responsive/size_utils.dart';

class SizeUtilsWidget extends StatelessWidget {
  const SizeUtilsWidget({
    super.key,
    required this.builder,
    required this.designSize,
  });

  final Function(BuildContext) builder;
  final Size designSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeUtils.instance.init(constraints: constraints, designSize: designSize);
      return builder(context);
    });
  }
}
