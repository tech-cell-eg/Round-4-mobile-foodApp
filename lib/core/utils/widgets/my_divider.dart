import 'package:flutter/material.dart';

import '../app_colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.height, this.endIndent, this.color = AppColors.grayColor, this.thickness = 1});

  final double? height;
  final double? endIndent;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      height: height,
      endIndent: endIndent,
    );
  }
}