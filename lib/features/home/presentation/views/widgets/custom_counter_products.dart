import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/app_responsive.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CustomCounterProducts extends StatefulWidget {
  const CustomCounterProducts({super.key});

  @override
  State<CustomCounterProducts> createState() => _CustomCounterProductsState();
}

class _CustomCounterProductsState extends State<CustomCounterProducts> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (counter > 1) {
                      counter--;
                    }
                  });
                },
                child: SvgPicture.asset(AppIcons.minFruitIcon)),
            SizedBox(
              width: AppResponsive.width(context, value: 20),
            ),
            Text('$counter', style: AppTextStyles.textStyle24),
            SizedBox(
              width: AppResponsive.width(context, value: 20),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    counter++;
                  });
                },
                child: SvgPicture.asset(AppIcons.addFruitIcon)),
          ],
        ),
        Spacer(),
        Text('\$ 2.99', style: AppTextStyles.textStyle32),
      ],
    );
  }
}