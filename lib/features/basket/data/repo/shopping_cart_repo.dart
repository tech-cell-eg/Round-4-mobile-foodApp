import 'package:dartz/dartz.dart';
import 'package:fruit_hub/features/basket/data/models/shopping_cart_model.dart';

abstract class ShoppingCartRepo {
  Future<Either<String, List<Item>>> getShoppingCart();
}