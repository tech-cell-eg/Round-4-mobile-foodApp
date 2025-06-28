import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/basket/data/models/shopping_cart_model.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productRepository) : super(ProductDetailsInitial());

  final ProductRepository productRepository;

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  void getProductDetails(int productId) async {
    try {
      final result = await productRepository.getProductDetails(productId: productId);
      result.fold(
        (error) => emit(ProductDetailsError(error)),
        (productDetails) => emit(ProductDetailsLoaded(productDetails)),
      );
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
