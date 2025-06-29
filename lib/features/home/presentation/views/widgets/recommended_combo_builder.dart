import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/utils/app_toast.dart';
import 'package:fruit_hub/core/utils/widgets/custom_app_loading.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_state.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/recommended_combo.dart';

class RecommendedComboBuilder extends StatefulWidget {
  const RecommendedComboBuilder({super.key});

  @override
  State<RecommendedComboBuilder> createState() =>
      _RecommendedComboBuilderState();
}

class _RecommendedComboBuilderState extends State<RecommendedComboBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            AppToast.showErrorToast(state.message);
          }
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CustomAppLoading());
          } else if (state is ProductLoaded ||
              state is ProductFavoriteToggled) {
            final products = context.read<ProductCubit>().products;
            return SizedBox(
              height: 220,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return RecommendedCombo(
                    product: products[index],
                    onAddToCart: () {
                      // Handle add to cart logic
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
