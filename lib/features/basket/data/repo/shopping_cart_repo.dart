import 'package:dartz/dartz.dart';
import 'package:fruit_hub/features/basket/data/models/shopping_cart_model.dart';

abstract class ShoppingCartRepo {
  Future<Either<String, List<Item>>> getShoppingCart();
  Future<Either<String, String>> payment({required String deliveryAddress, required String phoneNumber, required String cardHolderName, required String cardNumber, required String cardExpiry, required String cardCVC});
}