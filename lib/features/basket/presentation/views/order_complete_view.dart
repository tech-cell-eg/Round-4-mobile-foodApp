import 'package:flutter/material.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/order_complete_view_body.dart';

class OrderCompleteView extends StatelessWidget {
  const OrderCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrderCompleteViewBody(),
    );
  }
}
