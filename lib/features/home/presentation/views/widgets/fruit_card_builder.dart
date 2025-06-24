import 'package:flutter/material.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_card.dart';

class FruitCardBuilder extends StatelessWidget {
  const FruitCardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return FruitCard();
        },
      ),
    );
  }
}
