import 'package:flutter/material.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';

import 'custom_fruit_item.dart';

class MyBasketViewBody extends StatelessWidget {
  const MyBasketViewBody({super.key});

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
                itemCount: 10),
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
                      '\$100.00',
                      style: AppTextStyles.textStyle24,
                    ),
                  ],
                ),
                SizedBox(width: AppResponsive.width(context, value: 28),),
                CustomButton(text: 'Checkout', width: AppResponsive.width(context, value: 199), height: AppResponsive.height(context, value: 56),)
              ],
            ),
          )
        ],
      ),
    );
  }
}



