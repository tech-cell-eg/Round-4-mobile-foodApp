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
  List<ProductModel> recommendedCombos = [];
  List<ProductModel> categoryProducts = [];
  List<ProductModel> searchResults = [];

  ProductCubit({required this.productRepository, required this.favoritesRepo})
    : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);

  Future<void> getRecommendedCombos() async {
    emit(ProductLoading());
    try {
      final response = await productRepository.getRecommendedCombos();
      recommendedCombos = response.products;
      emit(RecommendedCombosLoaded(products: recommendedCombos));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  // Update your ProductCubit's toggleFavorite method
  Future<void> toggleFavorite(int productId) async {
    try {
      // Find the product in all relevant lists
      final productIndex = products.indexWhere((p) => p.id == productId);
      final comboIndex = recommendedCombos.indexWhere((p) => p.id == productId);
      final categoryIndex = categoryProducts.indexWhere(
        (p) => p.id == productId,
      );

      // Get current favorite status
      bool currentStatus = false;
      if (productIndex != -1) currentStatus = products[productIndex].isFavorite;
      if (comboIndex != -1)
        currentStatus = recommendedCombos[comboIndex].isFavorite;
      if (categoryIndex != -1)
        currentStatus = categoryProducts[categoryIndex].isFavorite;

      // Optimistic UI update
      emit(
        ProductFavoriteToggled(
          productId: productId,
          isFavorite: !currentStatus,
        ),
      );

      // Call API
      final response = await favoritesRepo.addToFavorites(productId);

      response.fold(
        (error) {
          // Revert if API call fails
          emit(
            ProductFavoriteToggled(
              productId: productId,
              isFavorite: currentStatus,
            ),
          );
          emit(ProductError(message: error));
        },
        (success) {
          // Update all relevant lists after successful API call
          if (productIndex != -1) {
            products[productIndex] = products[productIndex].copyWith(
              isFavorite: !currentStatus,
            );
          }
          if (comboIndex != -1) {
            recommendedCombos[comboIndex] = recommendedCombos[comboIndex]
                .copyWith(isFavorite: !currentStatus);
          }
          if (categoryIndex != -1) {
            categoryProducts[categoryIndex] = categoryProducts[categoryIndex]
                .copyWith(isFavorite: !currentStatus);
          }
          emit(
            ProductFavoriteToggled(
              productId: productId,
              isFavorite: !currentStatus,
            ),
          );
        },
      );
    } catch (e) {
      emit(ProductError(message: 'Failed to toggle favorite'));
      debugPrint('Error toggling favorite: $e');
    }
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(CategoryProductsLoading());
    print('Loading products for category $categoryId');
    try {
      final response = await productRepository.getProductsByCategory(
        categoryId,
      );
      categoryProducts = response.products;
      print('Loaded ${categoryProducts.length} products');
      emit(CategoryProductsLoaded(products: categoryProducts));
    } catch (e) {
      print('Error loading products: $e');
      emit(ProductError(message: e.toString()));
    }
  }

  // product_cubit.dart
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(ProductInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final response = await productRepository.searchProducts(query);
      searchResults = response.products;
      if (searchResults.isEmpty) {
        emit(SearchError(message: 'No results found for "$query"'));
      } else {
        emit(SearchLoaded(products: searchResults));
      }
    } catch (e) {
      emit(SearchError(message: 'Search failed. Please try again.'));
      debugPrint('Search error: $e');
    }
  }
}
