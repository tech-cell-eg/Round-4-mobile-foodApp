import 'package:flutter/material.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/custom_bottom_sheet.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/order_complete_view_body.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helper/app_validator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';
import 'custom_fruit_item.dart';

class MyBasketViewBody extends StatefulWidget {
  const MyBasketViewBody({super.key});

  @override
  State<MyBasketViewBody> createState() => _MyBasketViewBodyState();
}

class _MyBasketViewBodyState extends State<MyBasketViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => CustomFruitItem(),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: 10,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Total', style: AppTextStyles.textStyle16),
                    Text('\$100.00', style: AppTextStyles.textStyle24),
                  ],
                ),
                SizedBox(width: AppResponsive.width(context, value: 28)),
                CustomButton(
                  text: 'Checkout',
                  ontap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withAlpha(150),
                      builder:
                          (context) => Form(
                            key: _formKey,
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              GoRouter.of(
                                                context,
                                              ).pushReplacement(
                                                OrderCompleteViewBody
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
                                          backGroundColor: AppColors.whiteColor,
                                          fontColor: AppColors.orangeColor,
                                          border: Border.all(
                                            color: AppColors.orangeColor,
                                            width: 1,
                                          ),
                                        ),
                                        const Spacer(),
                                        CustomButton(
                                          text: 'Pay with card',
                                          ontap: () {
                                            if (_formKey.currentState!
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
                                                    ) => SingleChildScrollView(
                                                      child: ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                          maxHeight: AppResponsive.height(context, value: 680)
                                                        ),
                                                        child: IntrinsicHeight(
                                                          child: CustomBottomSheet(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal: 18,
                                                                    ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Card Holders Name',
                                                                      style:
                                                                          AppTextStyles
                                                                              .textStyle20,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 18,
                                                                    ),
                                                                    CustomTextField(
                                                                      hintText:
                                                                          'Adolphus Chris',
                                                                      validator:
                                                                          RequiredValidator(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 24,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal: 18,
                                                                    ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Card Number',
                                                                      style:
                                                                          AppTextStyles
                                                                              .textStyle20,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 18,
                                                                    ),
                                                                    CustomTextField(
                                                                      hintText:
                                                                          '1234 5678 9012 1314',
                                                                      validator:
                                                                          IntegerValidator(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 24,
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal: 18,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Text(
                                                                            'Date',
                                                                            style:
                                                                                AppTextStyles
                                                                                    .textStyle20,
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          SizedBox(
                                                                            width: 134,
                                                                            height: 56,
                                                                            child: CustomTextField(
                                                                              hintText:
                                                                                  '10/30',
                                                                              validator:
                                                                                  RequiredValidator(),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Text(
                                                                            'CCV',
                                                                            style:
                                                                                AppTextStyles
                                                                                    .textStyle20,
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          SizedBox(
                                                                            width: 134,
                                                                            height: 56,
                                                                            child: CustomTextField(
                                                                              hintText:
                                                                                  '123',
                                                                              validator:
                                                                                  CVVValidator(),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 24,
                                                              ),
                                                              Container(
                                                                width: double.infinity,
                                                                height: AppResponsive.height(
                                                                  context,
                                                                  value: 120,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.orangeColor,
                                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                                                                ),
                                                                child: Center(
                                                                  child: CustomButton(
                                                                    text: 'Complete Order',
                                                                    ontap: () {
                                                                      if (_formKey.currentState!
                                                                          .validate()) {
                                                                        GoRouter.of(
                                                                          context,
                                                                        ).pushReplacement(
                                                                          OrderCompleteViewBody
                                                                              .kOrderComplete,
                                                                        );
                                                                      }
                                                                    },
                                                                    fontColor: AppColors.orangeColor,
                                                                    backGroundColor: AppColors.whiteColor,
                                                                    width: AppResponsive.width(
                                                                      context,
                                                                      value: 140,
                                                                    ),
                                                                    height: AppResponsive.height(
                                                                      context,
                                                                      value: 56,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                          backGroundColor: AppColors.whiteColor,
                                          fontColor: AppColors.orangeColor,
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
                          ),
                    );
                  },
                  width: AppResponsive.width(context, value: 199),
                  height: AppResponsive.height(context, value: 56),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}