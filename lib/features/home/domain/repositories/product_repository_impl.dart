import 'package:fruit_hub/features/home/data_sources/remote/product_remote_data_source.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductsResponse> getRecommendedCombos() {
    return remoteDataSource.getRecommendedCombos();
  }
}
