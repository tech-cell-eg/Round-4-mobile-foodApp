import 'package:flutter/material.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/recommended_combo.dart';

class RecommendedComboBuilder extends StatelessWidget {
  const RecommendedComboBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return RecommendedCombo();
        },
      ),
    );
  }
}
