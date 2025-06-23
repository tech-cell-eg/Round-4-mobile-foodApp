import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/custom_text_field.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});
  static final String kAuthonticationView = "/Authontication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orangeColor,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 100),
              Image.asset("assets/images/fruit_basket_2.png"),
              const SizedBox(height: 10),
              SvgPicture.asset('assets/images/shadow_fruit_2.svg'),
              const SizedBox(height: 36),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: AppColors.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your username',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle20.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(hintText: "username"),
                    const SizedBox(height: 16),
                    Text(
                      'Enter your password',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle20.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(hintText: "password"),
                    const SizedBox(height: 16),
                    CustomButton(text: 'Start Ordering'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
