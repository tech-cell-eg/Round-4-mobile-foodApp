import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/app_responsive.dart';
import '../../../../../core/helper/app_validator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/widgets/custom_botton.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../order_complete_view.dart';
import 'card_info.dart';
import 'custom_bottom_sheet.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CustomBottomSheet(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery address',
                  style: AppTextStyles.textStyle20,
                ),
                const SizedBox(height: 18),
                CustomTextField(
                  hintText:
                  '10th avenue, Lekki, Lagos State',
                  validator: RequiredValidator(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Number we can call',
                  style: AppTextStyles.textStyle20,
                ),
                const SizedBox(height: 18),
                CustomTextField(
                  hintText: '09090605708',
                  validator: PhoneValidator(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Row(
                children: [
                  CustomButton(
                    text: 'Pay on delivery',
                    ontap: () {
                      if (formKey.currentState!
                          .validate()) {
                        GoRouter.of(
                          context,
                        ).pushReplacement(
                          OrderCompleteView
                              .kOrderComplete,
                        );
                      }
                    },
                    width: AppResponsive.width(
                      context,
                      value: 125,
                    ),
                    height: AppResponsive.height(
                      context,
                      value: 60,
                    ),
                    backGroundColor:
                    AppColors.whiteColor,
                    fontColor:
                    AppColors.orangeColor,
                    border: Border.all(
                      color: AppColors.orangeColor,
                      width: 1,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Pay with card',
                    ontap: () {
                      if (formKey.currentState!
                          .validate()) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                          Colors.transparent,
                          barrierColor: Colors.black
                              .withAlpha(150),
                          builder:
                              (
                              context,
                              ) => CardInfo(formKey: formKey),
                        );
                      }
                    },
                    width: AppResponsive.width(
                      context,
                      value: 125,
                    ),
                    height: AppResponsive.height(
                      context,
                      value: 60,
                    ),
                    backGroundColor:
                    AppColors.whiteColor,
                    fontColor:
                    AppColors.orangeColor,
                    border: Border.all(
                      color: AppColors.orangeColor,
                      width: 1,
                    ),
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