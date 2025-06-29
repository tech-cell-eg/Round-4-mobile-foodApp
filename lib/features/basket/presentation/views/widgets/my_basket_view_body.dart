import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/app_toast.dart';
import 'package:fruit_hub/core/utils/widgets/custom_app_loading.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';
import 'package:fruit_hub/features/basket/presentation/manger/basket/my_basket_cubit.dart';
import 'custom_fruit_item.dart';
import 'delivery_info.dart';

class MyBasketViewBody extends StatefulWidget {
  const MyBasketViewBody({super.key});

  @override
  State<MyBasketViewBody> createState() => _MyBasketViewBodyState();
}

class _MyBasketViewBodyState extends State<MyBasketViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    MyBasketCubit.get(context).getShoppingCart();
  }

  double calculateTotalPrice(List items) {
    double total = 0.0;
    for (var item in items) {
      total += (item.price ?? 0.0) * (item.quantity ?? 1);
    }
    return total;
  }

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
                    itemCount: state.items.length,
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
                          Text(
                            '\$ ${calculateTotalPrice(state.items)}',
                            style: AppTextStyles.textStyle24,
                          ),
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
                                (context) => DeliveryInfo(formKey: _formKey),
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
            return CustomAppLoading();
          }
        },
      ),
    );
  }
}
