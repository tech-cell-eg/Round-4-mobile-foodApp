import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/app_responsive.dart';
import '../../../../../core/helper/app_validator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/widgets/custom_botton.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../order_complete_view.dart';
import 'creadit_card_date_formatter.dart';
import 'creadit_card_number_formate.dart';
import 'custom_bottom_sheet.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({
    super.key,
    required this.deliveryAddress,
    required this.phoneNumber,
  });

  final String deliveryAddress;
  final String phoneNumber;

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController ccvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: AppResponsive.height(context, value: 700),
            ),
            child: IntrinsicHeight(
              child: CustomBottomSheet(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Holders Name',
                          style: AppTextStyles.textStyle20,
                        ),
                        const SizedBox(height: 18),
                        CustomTextField(
                          keyboardType: TextInputType.name,
                          controller: cardHolderNameController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z\s]+$'),
                            ),
                          ],
                          hintText: 'Adolphus Chris',
                          validator: HolderNameValidator(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Card Number', style: AppTextStyles.textStyle20),
                        const SizedBox(height: 18),
                        CustomTextField(
                          keyboardType: TextInputType.number,
                          controller: cardNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CreditCardNumberInputFormatter(),
                          ],
                          hintText: '1234 5678 9012 1314',
                          validator: CreditCardValidator(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date', style: AppTextStyles.textStyle20),
                                const SizedBox(height: 18),
                                SizedBox(
                                  width: AppResponsive.width(
                                    context,
                                    value: 134,
                                  ),
                                  height: AppResponsive.height(
                                    context,
                                    value: 80,
                                  ),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: expiryDateController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CreditCardDateInputFormatter(),
                                    ],
                                    hintText: '10/30',
                                    validator: ExpiryDateValidator(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CCV', style: AppTextStyles.textStyle20),
                                const SizedBox(height: 18),
                                SizedBox(
                                  width: AppResponsive.width(
                                    context,
                                    value: 134,
                                  ),
                                  height: AppResponsive.height(
                                    context,
                                    value: 80,
                                  ),
                                  child: CustomTextField(
                                    hintText: '123',
                                    keyboardType: TextInputType.number,
                                    controller: ccvController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: CVVValidator(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: AppResponsive.height(context, value: 100),
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: CustomButton(
                        text: 'Complete Order',
                        ontap: () {
                          if (formKey.currentState!.validate()) {
                            // MyBasketCubit.get(context).payment(
                            //   deliveryAddress: widget.deliveryAddress,
                            //   phoneNumber: widget.phoneNumber,
                            //   cardHolderName: cardHolderNameController.text,
                            //   cardNumber: cardNumberController.text,
                            //   cardExpiry: expiryDateController.text,
                            //   cardCVC: ccvController.text,
                            // );

                            GoRouter.of(
                              context,
                            ).pushReplacement(OrderCompleteView.kOrderComplete);
                          }
                        },
                        fontColor: AppColors.orangeColor,
                        backGroundColor: AppColors.whiteColor,
                        width: AppResponsive.width(context, value: 140),
                        height: AppResponsive.height(context, value: 56),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
