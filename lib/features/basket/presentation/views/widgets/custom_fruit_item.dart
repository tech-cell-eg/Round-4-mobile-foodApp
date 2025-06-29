import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CustomFruitItem extends StatelessWidget {
  const CustomFruitItem({super.key, required this.fruitName, required this.quantity, required this.price, required this.image});

  final String fruitName;
  final int quantity;
  final double price;
  final String image;

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
            child: Image.network(image, height: 40, width: 40,),
          ),
          SizedBox(
            width: 14,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(fruitName, style: AppTextStyles.textStyle16,),
              Text('$quantity packs', style: AppTextStyles.textStyle14.copyWith(color: AppColors.blackColor),)
            ],
          ),
          Spacer(),
          Text('\$ ${price.toStringAsFixed(2)}', style: AppTextStyles.textStyle16),
        ],
      ),
    );
  }
}