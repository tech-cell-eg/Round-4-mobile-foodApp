import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.focusNode,
    required this.onSearchChanged,
  });

  final FocusNode focusNode;
  final Function(String) onSearchChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResults = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.mediamgrayColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 56,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search, color: AppColors.lavenderColor),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: widget.focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for fruit salad combos',
                    hintStyle: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: AppTextStyles.textStyle14.fontSize,
                    ),
                  ),
                  onChanged: (value) {
                    widget.onSearchChanged(value);
                    setState(() {
                      _showResults = value.isNotEmpty;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    // Filter icon functionality
                  },
                  child: SvgPicture.asset(AppIcons.filterIcon),
                ),
              ),
            ],
          ),
        ),
        if (_showResults)
          Container(
            width: double.infinity, // Same width as search bar
            height: 100, // Fixed height
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: _buildSearchResults(_searchController.text),
          ),
      ],
    );
  }

  Widget _buildSearchResults(String query) {
    // Replace with your actual data
    final results =
        query.isEmpty
            ? <String>[]
            : ['Fruit Salad 1', 'Fruit Salad 2', 'Combo Salad']
                .where(
                  (item) => item.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No dishes found for "$query"',
          style: AppTextStyles.textStyle14,
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children:
          results
              .map(
                (result) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(result, style: AppTextStyles.textStyle14),
                ),
              )
              .toList(),
    );
  }
}
