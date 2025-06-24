import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/go_back_icon.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/custom_bottom_sheet.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/my_basket_view_body.dart';

class MyBasketView extends StatelessWidget {
  const MyBasketView({super.key});
  static final String kBasketView = "/basket";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          height: 150,
          color: AppColors.orangeColor,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Row(
              children: [
                GoBackIcon(),
                const SizedBox(width: 70),
                Text(
                  'My Basket',
                  style: AppTextStyles.textStyle24.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: MyBasketViewBody(),
    );
  }
}
