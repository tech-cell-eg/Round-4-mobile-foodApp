import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/app_responsive.dart';
import '../../../../../core/helper/app_validator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/widgets/custom_botton.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../../manger/basket/my_basket_cubit.dart';
import '../order_complete_view.dart';
import 'card_info.dart';
import 'custom_bottom_sheet.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({super.key});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
              maxHeight: AppResponsive.height(context, value: 550),
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
                          'Delivery address',
                          style: AppTextStyles.textStyle20,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          controller: deliveryAddressController,
                          hintText: '10th avenue, Lekki, Lagos State',
                          validator: DeliveryAddressValidator(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Number we can call',
                          style: AppTextStyles.textStyle20,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          hintText: '09090605708',
                          validator: PhoneValidator(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          CustomButton(
                            text: 'Pay on delivery',
                            ontap: () {
                              if (formKey.currentState!.validate()) {
                                GoRouter.of(context).pushReplacement(
                                  OrderCompleteView.kOrderComplete,
                                );
                              }
                            },
                            width: AppResponsive.width(context, value: 125),
                            height: AppResponsive.height(context, value: 60),
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
                              if (formKey.currentState!.validate()) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.black.withAlpha(150),
                                  builder:
                                      (context) => BlocProvider.value(
                                        value: context.read<MyBasketCubit>(),
                                        child: CardInfo(
                                          deliveryAddress:
                                              deliveryAddressController.text,
                                          phoneNumber: phoneController.text,
                                        ),
                                      ),
                                );
                              }
                            },
                            width: AppResponsive.width(context, value: 125),
                            height: AppResponsive.height(context, value: 60),
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
          ),
        ),
      ),
    );
  }
}
