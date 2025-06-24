import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';

import 'custom_fruit_item.dart';

class LoveViewBody extends StatelessWidget {
  const LoveViewBody({super.key});

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
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
