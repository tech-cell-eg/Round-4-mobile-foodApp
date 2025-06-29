import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:fruit_hub/features/home/presentation/manger/products/product_state.dart';
import 'package:fruit_hub/features/love_screen/data/repo/favorites_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;
  final FavoritesRepo favoritesRepo;
  List<ProductModel> products = [];

  ProductCubit({required this.productRepository, required this.favoritesRepo})
    : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);

  Future<void> getRecommendedCombos() async {
    emit(ProductLoading());
    try {
      final response = await productRepository.getRecommendedCombos();
      products = response.products;
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> toggleFavorite(int productId) async {
    try {
      final productIndex = products.indexWhere((p) => p.id == productId);
      if (productIndex == -1) return;

      // Optimistic UI update - don't modify the original list yet
      emit(
        ProductFavoriteToggled(
          productId: productId,
          isFavorite: !products[productIndex].isFavorite,
        ),
      );

      final response = await favoritesRepo.addToFavorites(productId);

      response.fold(
        (error) {
          // Revert UI on error
          emit(
            ProductFavoriteToggled(
              productId: productId,
              isFavorite: products[productIndex].isFavorite,
            ),
          );
          emit(ProductError(message: error));
        },
        (success) {
          // Only update the actual product list after successful API call
          final updatedProduct = products[productIndex].copyWith(
            isFavorite: !products[productIndex].isFavorite,
          );
          products[productIndex] = updatedProduct;
          debugPrint('Favorite toggled successfully for product $productId');
        },
      );
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      emit(ProductError(message: 'Failed to toggle favorite'));
    }
  }
}
