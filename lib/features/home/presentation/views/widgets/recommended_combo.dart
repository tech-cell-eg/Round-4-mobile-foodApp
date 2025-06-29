import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_state.dart';
import 'package:go_router/go_router.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';

class RecommendedCombo extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onAddToCart;

  const RecommendedCombo({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final productCubit = context.read<ProductCubit>();
        bool isFavorite = product.isFavorite;
        if (state is ProductFavoriteToggled && state.productId == product.id) {
          isFavorite = state.isFavorite;
        }
        return GestureDetector(
          onTap: () {
            context.pushNamed('fruitDetails', extra: product.id);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(20),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Image.network(
                          product.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.fastfood, size: 60),
                        ),
                        Text(
                          product.name,
                          style: AppTextStyles.textStyle16,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text('\$ ', style: AppTextStyles.textStyle14),
                              Text(
                                product.price.toStringAsFixed(2),
                                style: AppTextStyles.textStyle14,
                              ),
                              const Spacer(flex: 1),
                              IconButton(
                                icon: SvgPicture.asset(AppIcons.addFruitIcon),
                                onPressed: () {
                                  ProductDetailsCubit.get(
                                    context,
                                  ).addToBasket(product.id, 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon:
                          isFavorite
                              ? Icon(
                                Icons.favorite,
                                size: 16,
                                color: Colors.red,
                              )
                              : SvgPicture.asset(
                                AppIcons.favoriteIcon,
                                height: 16,
                                width: 16,
                              ),
                      onPressed: () {
                        productCubit.toggleFavorite(product.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
