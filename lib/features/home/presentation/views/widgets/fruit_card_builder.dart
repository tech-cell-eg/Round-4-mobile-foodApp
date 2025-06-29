import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/utils/widgets/custom_app_loading.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_state.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_card.dart';

class FruitCardBuilder extends StatelessWidget {
  final int categoryId;

  const FruitCardBuilder({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    // Fetch products when categoryId changes
    context.read<ProductCubit>().getProductsByCategory(categoryId);

    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) {
        return current is CategoryProductsLoaded ||
            current is CategoryProductsLoading ||
            current is ProductError ||
            current is ProductFavoriteToggled;
      },
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();

        if (state is CategoryProductsLoading) {
          return const Center(child: CustomAppLoading());
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is CategoryProductsLoaded ||
            cubit.categoryProducts.isNotEmpty) {
          return SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cubit.categoryProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return FruitCard(product: cubit.categoryProducts[index]);
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
