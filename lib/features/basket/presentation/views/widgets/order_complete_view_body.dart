import 'package:flutter/material.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/helper/app_router.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/features/home/presentation/views/home_view.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/app_images.dart';

class OrderCompleteViewBody extends StatelessWidget {
  const OrderCompleteViewBody({super.key});

  static final String kOrderComplete = "/completeOrder";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            AppImages.complete,
            width: AppResponsive.width(context, value: 164),
            height: AppResponsive.height(context, value: 164),
            repeat: false,
          ),
          SizedBox(height: AppResponsive.height(context, value: 20)),
          Text('Congratulations!!!', style: AppTextStyles.textStyle32),
          SizedBox(height: AppResponsive.height(context, value: 18)),
          Text(
            'Your order have been taken and is being attended to',
            style: AppTextStyles.textStyle20,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppResponsive.height(context, value: 60)),
          CustomButton(
            text: 'Track order',
            width: AppResponsive.width(context, value: 120),
            height: AppResponsive.height(context, value: 56),
            backGroundColor: AppColors.whiteColor,
            fontColor: AppColors.orangeColor,
            border: Border.all(color: AppColors.orangeColor, width: 1),
          ),
          SizedBox(height: AppResponsive.height(context, value: 40)),
          CustomButton(
            text: 'Continue shopping',
            width: AppResponsive.width(context, value: 181),
            height: AppResponsive.height(context, value: 56),
            ontap: () {
              GoRouter.of(context).pushReplacement(HomeView.kHomeView);
            },
          ),
        ],
      ),
    );
  }
}
