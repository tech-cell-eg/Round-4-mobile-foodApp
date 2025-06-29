import 'package:fruit_hub/features/home/domain/models/product_model.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded({required this.products});
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
