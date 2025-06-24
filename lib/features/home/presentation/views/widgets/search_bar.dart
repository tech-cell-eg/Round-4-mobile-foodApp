import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.mediamgrayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.search, color: AppColors.lavenderColor),
                  ),
                  Text(
                    'Search for fruit salad combos',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: AppTextStyles.textStyle14.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(AppIcons.filterIcon),
          ),
        ],
      ),
    );
  }
}
