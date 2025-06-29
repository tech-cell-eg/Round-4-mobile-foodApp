import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';
import 'package:fruit_hub/features/love_screen/data/models/favorite_model.dart';

class FavoritItem extends StatelessWidget {
  final FavoriteItem item;

  const FavoritItem({super.key, required this.item});

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
              image: DecorationImage(
                image: NetworkImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: AppTextStyles.textStyle16),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: AppTextStyles.textStyle14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: SvgPicture.asset(AppIcons.addFruitIcon),
            onPressed: () {
              ProductDetailsCubit.get(context).addToBasket(item.id, 1);
            },
          ),
        ],
      ),
    );
  }
}
