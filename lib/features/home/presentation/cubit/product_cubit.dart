import 'package:bloc/bloc.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:fruit_hub/features/home/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository}) : super(ProductInitial());

  Future<void> getRecommendedCombos() async {
    emit(ProductLoading());
    try {
      final response = await productRepository.getRecommendedCombos();
      emit(ProductLoaded(products: response.products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
