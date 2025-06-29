import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository productRepository;

  ProductDetailsCubit({required this.productRepository})
    : super(ProductDetailsInitial());

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final Either<String, ProductModel> result = await productRepository
          .getProductDetails(productId: productId);

      result.fold(
        (error) => emit(ProductDetailsError(error: error)),
        (product) => emit(ProductDetailsLoaded(product: product)),
      );
    } catch (e) {
      emit(ProductDetailsError(error: e.toString()));
    }
  }
}
