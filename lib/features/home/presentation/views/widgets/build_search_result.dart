import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:go_router/go_router.dart';

Widget buildSearchResults(List<ProductModel> products, BuildContext context) {
  if (products.isEmpty) {
    return Center(
      child: Text('No dishes found', style: AppTextStyles.textStyle14),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: 0, // Remove shadow
        child: ListTile(
          leading:
              product.image.isNotEmpty
                  ? Image.network(
                    product.image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.fastfood, color: AppColors.orangeColor),
                  )
                  : Icon(Icons.fastfood, color: AppColors.orangeColor),
          title: Text(product.name, style: AppTextStyles.textStyle14),
          subtitle: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: AppTextStyles.textStyle16,
          ),
          onTap: () {
            context.pushNamed('fruitDetails', extra: product.id);
          },
        ),
      );
    },
  );
}
