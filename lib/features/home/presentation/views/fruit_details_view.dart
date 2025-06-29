import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository_impl.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_details_view_body.dart';

class FruitDetailsView extends StatelessWidget {
  const FruitDetailsView({super.key, required this.productId});

  final int productId;

  static const String kFruitDetailsView = "/fruitDetails";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ProductDetailsCubit(productRepository: ProductRepositoryImpl(apiHelper: ApiHelper()))..getProductDetails(productId),
      child: Scaffold(body: ProductDetailsViewBody()),
    );
  }
}
