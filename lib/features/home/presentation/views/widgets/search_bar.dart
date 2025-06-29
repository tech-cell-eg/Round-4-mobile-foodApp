import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_state.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/build_search_result.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        context.read<ProductCubit>().searchProducts(query);
      }
    });
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
                  onChanged: _onSearchChanged,
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
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return SizedBox(
                width: double.infinity,
                height: 100,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is SearchLoaded) {
              return Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: buildSearchResults(state.products, context),
              );
            } else if (state is SearchError) {
              return Container(
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(state.message, style: AppTextStyles.textStyle14),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
