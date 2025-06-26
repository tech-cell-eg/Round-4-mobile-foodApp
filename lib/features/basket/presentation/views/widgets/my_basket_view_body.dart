import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/app_toast.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';
import 'package:fruit_hub/features/basket/presentation/manger/basket/my_basket_cubit.dart';
import 'package:fruit_hub/features/basket/presentation/views/order_complete_view.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/custom_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      child: BlocConsumer<MyBasketCubit, MyBasketState>(
        listener: (context, state) {
          if (state is MyBasketError) {
            return AppToast.showErrorToast(state.error);
          }
        },
        builder: (context, state) {
          if (state is MyBasketLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder:
                        (context, index) => CustomFruitItem(
                          fruitName: state.items[index].name ?? '',
                          quantity: state.items[index].quantity ?? 0,
                          price: state.items[index].price ?? 0.0,
                        ),
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
                                                              constraints:
                                                                  BoxConstraints(
                                                                    maxHeight:
                                                                        AppResponsive.height(
                                                                          context,
                                                                          value:
                                                                              700,
                                                                        ),
                                                                  ),
                                                              child: IntrinsicHeight(
                                                                child: CustomBottomSheet(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            18,
                                                                      ),
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Card Holders Name',
                                                                            style:
                                                                                AppTextStyles.textStyle20,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                18,
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
                                                                      height:
                                                                          24,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            18,
                                                                      ),
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Card Number',
                                                                            style:
                                                                                AppTextStyles.textStyle20,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                18,
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
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              18,
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Date',
                                                                                    style:
                                                                                        AppTextStyles.textStyle20,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height:
                                                                                        18,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: AppResponsive.width(
                                                                                      context,
                                                                                      value:
                                                                                          134,
                                                                                    ),
                                                                                    height: AppResponsive.height(
                                                                                      context,
                                                                                      value:
                                                                                          80,
                                                                                    ),
                                                                                    child: CustomTextField(
                                                                                      hintText:
                                                                                          '10/30',
                                                                                      validator:
                                                                                          RequiredValidator(),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'CCV',
                                                                                    style:
                                                                                        AppTextStyles.textStyle20,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height:
                                                                                        18,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: AppResponsive.width(
                                                                                      context,
                                                                                      value:
                                                                                          134,
                                                                                    ),
                                                                                    height: AppResponsive.height(
                                                                                      context,
                                                                                      value:
                                                                                          80,
                                                                                    ),
                                                                                    child: CustomTextField(
                                                                                      hintText:
                                                                                          '123',
                                                                                      validator:
                                                                                          CVVValidator(),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          double
                                                                              .infinity,
                                                                      height: AppResponsive.height(
                                                                        context,
                                                                        value:
                                                                            100,
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                        color:
                                                                            AppColors.orangeColor,
                                                                        borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(
                                                                            24,
                                                                          ),
                                                                          topLeft: Radius.circular(
                                                                            24,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child: Center(
                                                                        child: CustomButton(
                                                                          text:
                                                                              'Complete Order',
                                                                          ontap: () {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              GoRouter.of(
                                                                                context,
                                                                              ).pushReplacement(
                                                                                OrderCompleteView.kOrderComplete,
                                                                              );
                                                                            }
                                                                          },
                                                                          fontColor:
                                                                              AppColors.orangeColor,
                                                                          backGroundColor:
                                                                              AppColors.whiteColor,
                                                                          width: AppResponsive.width(
                                                                            context,
                                                                            value:
                                                                                140,
                                                                          ),
                                                                          height: AppResponsive.height(
                                                                            context,
                                                                            value:
                                                                                56,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
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
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.orangeColor,
                size: 50,
              ),
            );
          }
        },
      ),
    );
  }
}
