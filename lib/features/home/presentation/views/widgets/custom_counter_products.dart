import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/app_responsive.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CustomCounterProducts extends StatefulWidget {
  const CustomCounterProducts({super.key, required this.price, required this.quantity, required this.onCounterChanged});

  final double price;
  final int quantity;
  final Function(int) onCounterChanged;

  @override
  State<CustomCounterProducts> createState() => _CustomCounterProductsState();
}

class _CustomCounterProductsState extends State<CustomCounterProducts> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.quantity < 1) {
      return Center(
        child: Text(
          'Out of stock',
          style: AppTextStyles.textStyle16.copyWith(color: Colors.red),
        ),
      );
    } else {
      return Row(
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      if (counter > 1) {
                        counter--;
                        widget.onCounterChanged(counter);
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
                      if (counter < widget.quantity) {
                        counter++;
                        widget.onCounterChanged(counter);
                      }
                    });
                  },
                  child: SvgPicture.asset(AppIcons.addFruitIcon)),
            ],
          ),
          Spacer(),
          Text('\$ ${widget.price}', style: AppTextStyles.textStyle32),
        ],
      );
    }
  }
}