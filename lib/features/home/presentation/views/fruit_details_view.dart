import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository_impl.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_details_view_body.dart';

class FruitDetailsView extends StatefulWidget {
  const FruitDetailsView({super.key, required this.productId});

  final int productId;

  static const String kFruitDetailsView = "/fruitDetails";

  @override
  State<FruitDetailsView> createState() => _FruitDetailsViewState();
}

class _FruitDetailsViewState extends State<FruitDetailsView> {

  @override
  void initState() {
    super.initState();
    ProductDetailsCubit.get(context).getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProductDetailsViewBody());
  }
}