import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../app_colors.dart';
import '../app_icons.dart';
import '../app_text_styles.dart';

class GoBackIcon extends StatelessWidget {
  const GoBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.arrowBackIcon, width: 10, height: 20),
            Text('Go back', style: AppTextStyles.textStyle16),
          ],
        ),
      ),
    );
  }
}
