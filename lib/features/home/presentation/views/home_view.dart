import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_card_builder.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/recommended_combo_builder.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static final String kHomeView = "/home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? selectedIndex;
  final List<String> menuItems = ["Hottest", "Popular", "New Combo", "Top"];
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: CustomAppbar(),
                ),
                Text(
                  'Hello Tony, What fruit salad combo do you want today?',
                  style: AppTextStyles.textStyle20,
                  maxLines: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomSearchBar(
                    focusNode: _searchFocusNode,
                    onSearchChanged: (query) {
                      // You can handle search changes here if needed
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text('Recommended Combo', style: AppTextStyles.textStyle24),
                const SizedBox(height: 16),
                RecommendedComboBuilder(),
                const SizedBox(height: 24),
                fruitTopicSelect(),
                const SizedBox(height: 20),
                FruitCardBuilder(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fruitTopicSelect() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(menuItems.length, (index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
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
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      height: 2,
                      width: menuItems[index].length * 4,
                      color: AppColors.orangeColor,
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
