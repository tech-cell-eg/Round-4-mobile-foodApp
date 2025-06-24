import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/helper/app_validator.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});
  static final String kRegistrationView = "/registration";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orangeColor,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 80),
              Image.asset("assets/images/fruit_basket_2.png"),
              const SizedBox(height: 10),
              SvgPicture.asset('assets/images/shadow_fruit_2.svg'),
              const SizedBox(height: 24),
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
                      'Create your account',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle20.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle16.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      hintText: "username",
                      validator: RequiredValidator(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle16.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      hintText: "email@example.com",
                      validator: EmailValidator(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle16.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      hintText: "+1234567890",
                      validator: PhoneValidator(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle16.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      hintText: "Your address",
                      validator: RequiredValidator(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle16.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      hintText: "password",
                      validator: PasswordValidator(),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppTextStyles.textStyle16.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      hintText: "re-enter password",
                      validator: RequiredValidator(),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Create Account',
                      ontap: () {
                        // Handle registration logic
                        context.goNamed('home');
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed('Authontication');
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: AppTextStyles.textStyle16.fontSize,
                              color: AppColors.blackColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orangeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
