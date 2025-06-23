import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';

import 'custom_counter_products.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Container(
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
          pinned: true,
          backgroundColor: AppColors.orangeColor,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(color: AppColors.orangeColor),
              child: SizedBox(
                width: AppResponsive.width(context, value: 176),
                height: AppResponsive.height(context, value: 176),
                child: Image(image: AssetImage('assets/images/food.png')),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              height: 20,
              width: double.infinity,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quinoa Fruit Salad', style: AppTextStyles.textStyle32),
                SizedBox(height: AppResponsive.height(context, value: 24)),
                CustomCounterProducts(),
                SizedBox(height: AppResponsive.height(context, value: 24)),
                MyDivider(),
                SizedBox(height: AppResponsive.height(context, value: 24)),
                Text('One Pack Contains:', style: AppTextStyles.textStyle20),
                SizedBox(height: AppResponsive.height(context, value: 6)),
                MyDivider(
                  color: AppColors.orangeColor,
                  thickness: 2,
                  endIndent: AppResponsive.width(context, value: 153),
                ),
                SizedBox(height: AppResponsive.height(context, value: 8)),
                Text(
                  'Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.',
                  style: AppTextStyles.textStyle16,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppResponsive.height(context, value: 24)),
                MyDivider(),
                Text(
                  'If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you. make',
                  style: AppTextStyles.textStyle16,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppResponsive.height(context, value: 24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.orangeColor.withAlpha(60),
                      child: SvgPicture.asset(
                        AppIcons.favoriteIcon,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    SizedBox(width: AppResponsive.width(context, value: 16)),
                    Container(
                      width: AppResponsive.width(context, value: 219),
                      height: AppResponsive.height(context, value: 56),
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Add to basket',
                          style: AppTextStyles.textStyle16.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}





