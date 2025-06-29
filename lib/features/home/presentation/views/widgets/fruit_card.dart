import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class FruitCard extends StatelessWidget {
  const FruitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('fruitDetails');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          height: 160,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.darkGrayColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(10),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/images/food.png',
                      height: 60,
                      width: 60,
                    ),
                    Text(
                      "Quinoa fruit salad",
                      style: AppTextStyles.textStyle16,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text('\$ ', style: AppTextStyles.textStyle14),
                          Text('2,000 ', style: AppTextStyles.textStyle14),
                          Spacer(flex: 1),
                          IconButton(
                            icon: SvgPicture.asset(AppIcons.addFruitIcon),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.favoriteIcon,
                    height: 16,
                    width: 16,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
