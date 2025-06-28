part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsLoaded(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String error;

  ProductDetailsError(this.error);
}
