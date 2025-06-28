import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app_colors.dart';

class CustomAppLoading extends StatelessWidget {
  const CustomAppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColors.orangeColor,
        size: 35,
      ),
    );
  }
}