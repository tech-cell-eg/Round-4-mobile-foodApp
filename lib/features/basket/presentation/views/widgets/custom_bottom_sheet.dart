import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/helper/app_router.dart';
import 'package:fruit_hub/core/helper/app_validator.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.children, required this.height});

  final List<Widget> children;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.whiteColor,
            child: SvgPicture.asset(AppIcons.closeIcon),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            height: AppResponsive.height(context, value: height),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Column(
                children: children
              ),
            ),
          ),
        ),
      ],
    );
  }
}



