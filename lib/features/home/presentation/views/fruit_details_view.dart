import 'package:flutter/material.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/fruit_details_view_body.dart';

class FruitDetailsView extends StatelessWidget {
  const FruitDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductDetailsViewBody(),
    );
  }
}
