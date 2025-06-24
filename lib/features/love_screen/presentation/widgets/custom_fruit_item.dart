import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CustomFruitItem extends StatelessWidget {
  const CustomFruitItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.grayColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(AppImages.food, height: 40, width: 40),
          ),
          SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Quinoa fruit salad', style: AppTextStyles.textStyle16),
              Text(
                '2packs',
                style: AppTextStyles.textStyle14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text('\$20.00', style: AppTextStyles.textStyle16),
              IconButton(
                icon: SvgPicture.asset(AppIcons.addFruitIcon),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
