import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(AppIcons.drawerIcon),
          onPressed: () {
            context.pushNamed('love');
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_basket, color: AppColors.orangeColor),
          onPressed: () {
            context.pushNamed('basket');
          },
        ),
      ],
    );
  }
}
