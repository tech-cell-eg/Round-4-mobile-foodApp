import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository productRepository;

  ProductDetailsCubit({required this.productRepository})
    : super(ProductDetailsInitial());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  ProductModel? product;

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final Either<String, ProductModel> result = await productRepository
          .getProductDetails(productId: productId);

      result.fold(
        (error) => emit(ProductDetailsError(error: error)),
        (product) {
          this.product = product;
          emit(ProductDetailsLoaded());
        },
      );
    } catch (e) {
      emit(ProductDetailsError(error: e.toString()));
    }
  }

  Future<void> addToBasket(int productId, int quantity) async {
    emit(ProductDetailsLoading());
    try {
      final Either<String, String> result = await productRepository
          .addToBasket(productId: productId, quantity: quantity);

      result.fold(
        (error) => emit(ProductAddToBasketFailure(error: error)),
        (successMessage) => emit(ProductAddToBasketSuccess(message: successMessage)),
      );
    } catch (e) {
      emit(ProductDetailsError(error: e.toString()));
    }
  }
}
