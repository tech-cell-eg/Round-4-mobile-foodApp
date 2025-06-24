import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  static final String kWelcomeView = "/welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orangeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/images/fruit_basket_1.png"),
          SizedBox(height: 10),
          SvgPicture.asset('assets/images/shadow_fruit_1.svg'),
          SizedBox(height: 36),
          Container(
            width: double.infinity,
            color: AppColors.whiteColor,
            height:
                (MediaQuery.of(context).size.height / 3) +
                (MediaQuery.of(context).size.height / 10),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get The Freshest Fruit Salad Combo',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: AppTextStyles.textStyle20.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We deliver the best and freshest fruit salad in town. Order for a combo today!!!',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: AppTextStyles.textStyle16.fontSize,
                      color: AppColors.lavenderColor,
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomButton(
                    text: 'Let’s Continue',
                    ontap: () {
                      context.goNamed('Authontication');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
