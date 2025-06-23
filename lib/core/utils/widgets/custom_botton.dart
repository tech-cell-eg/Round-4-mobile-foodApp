import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  Color backGroundColor;
  Color fontColor;
  double width;
  double height;
  VoidCallback? ontap;
  CustomButton({
    super.key,
    this.ontap,
    required this.text,
    this.backGroundColor = AppColors.orangeColor,
    this.width = 330,
    this.height = 56,
    this.fontColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: fontColor,
              fontSize: 16,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
