// Example content widgets - you should create these in your widgets folder
import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';

class HottestContent extends StatelessWidget {
  const HottestContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Hottest Items', style: AppTextStyles.textStyle20)],
    );
  }
}

class PopularContent extends StatelessWidget {
  const PopularContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Popular Items', style: AppTextStyles.textStyle20),
        // Add your popular items content here
      ],
    );
  }
}

class ComboContent extends StatelessWidget {
  const ComboContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Combo Items', style: AppTextStyles.textStyle20)],
    );
  }
}

class TopContent extends StatelessWidget {
  const TopContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Top Items', style: AppTextStyles.textStyle20)],
    );
  }
}
