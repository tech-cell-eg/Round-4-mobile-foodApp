import 'package:fruit_hub/features/home/domain/models/product_model.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded({required this.products});
}

class RecommendedCombosLoaded extends ProductState {
  final List<ProductModel> products;
  RecommendedCombosLoaded({required this.products});
}

class CategoryProductsLoading extends ProductState {}

class CategoryProductsLoaded extends ProductState {
  final List<ProductModel> products;
  CategoryProductsLoaded({required this.products});
}

final class ProductFavoriteToggled extends ProductState {
  final int productId;
  final bool isFavorite;
  ProductFavoriteToggled({required this.productId, required this.isFavorite});
}

final class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});
}

class SearchLoading extends ProductState {}

class SearchLoaded extends ProductState {
  final List<ProductModel> products;
  SearchLoaded({required this.products});
}

class SearchError extends ProductState {
  final String message;
  SearchError({required this.message});
}
