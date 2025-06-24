import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_card_builder.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_text_selection.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/recommended_combo_builder.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static final String kHomeView = "/home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? selectedIndex; // Tracks which text is selected
  final List<String> menuItems = ["Hottest", "Popular", "New Combo", "Top"];

  // Widgets to show based on selection
  final List<Widget> contentWidgets = [
    HottestContent(),
    PopularContent(),
    ComboContent(),
    TopContent(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: CustomAppbar(),
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    'Hello Tony, What fruit salad combo do you want today?',
                    style: AppTextStyles.textStyle20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomSearchBar(),
            ),
            const Spacer(flex: 1),
            Row(
              children: [
                Text('Recommended Combo', style: AppTextStyles.textStyle24),
              ],
            ),
            RecommendedComboBuilder(),
            const Spacer(flex: 1),
            fruitTopicSelect(),

            const SizedBox(height: 20),
            FruitCardBuilder(),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Row fruitTopicSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(menuItems.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () => setState(() => selectedIndex = index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                menuItems[index],
                style:
                    isSelected
                        ? AppTextStyles.textStyle24.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        )
                        : AppTextStyles.textStyle16,
              ),
              if (isSelected)
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      height: 2,
                      width: menuItems[index].length * 4,
                      color: AppColors.orangeColor,
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}
