import 'package:fruit_hub/features/home/domain/models/product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsLoaded({required this.product});
}

class ProductDetailsError extends ProductDetailsState {
  final String error;

  ProductDetailsError({required this.error});
}
