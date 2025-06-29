import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/utils/widgets/custom_app_loading.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_state.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/recommended_combo.dart';

class RecommendedComboBuilder extends StatelessWidget {
  const RecommendedComboBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) {
        return current is RecommendedCombosLoaded ||
            current is ProductLoading ||
            current is ProductError;
      },
      builder: (context, state) {
        if (state is ProductLoading &&
            context.read<ProductCubit>().recommendedCombos.isEmpty) {
          return const Center(child: CustomAppLoading());
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is RecommendedCombosLoaded ||
            context.read<ProductCubit>().recommendedCombos.isNotEmpty) {
          final products = context.read<ProductCubit>().recommendedCombos;
          return SizedBox(
            height: 220,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return RecommendedCombo(product: products[index]);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
