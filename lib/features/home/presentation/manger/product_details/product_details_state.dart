import 'package:fruit_hub/features/home/domain/models/product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {}

class ProductDetailsError extends ProductDetailsState {
  final String error;

  ProductDetailsError({required this.error});
}

class ProductAddToBasketSuccess extends ProductDetailsState {
  final String message;

  ProductAddToBasketSuccess({required this.message});
}

class ProductAddToBasketFailure extends ProductDetailsState {
  final String error;

  ProductAddToBasketFailure({required this.error});
}
