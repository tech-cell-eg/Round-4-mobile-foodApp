import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/basket/data/models/shopping_cart_model.dart';
import 'package:fruit_hub/features/basket/data/repo/shopping_cart_repo.dart';
import 'package:meta/meta.dart';

part 'my_basket_state.dart';

class MyBasketCubit extends Cubit<MyBasketState> {
  MyBasketCubit(this.shoppingCartRepo) : super(MyBasketInitial());

  final ShoppingCartRepo shoppingCartRepo;

  static MyBasketCubit get(context) => BlocProvider.of(context);

  void getShoppingCart() async {
    await shoppingCartRepo
        .getShoppingCart()
        .then((result) {
          result.fold(
            (error) {
              emit(MyBasketError(error));
            },
            (items) {
              emit(MyBasketLoaded(items));
            },
          );
        })
        .catchError((error) {
          emit(MyBasketError(error.toString()));
        });
  }

  void payment({
    required String deliveryAddress,
    required String phoneNumber,
    required String cardHolderName,
    required String cardNumber,
    required String cardExpiry,
    required String cardCVC,
  }) async {
    await shoppingCartRepo
        .payment(
          deliveryAddress: deliveryAddress,
          phoneNumber: phoneNumber,
          cardHolderName: cardHolderName,
          cardNumber: cardNumber,
          cardExpiry: cardExpiry,
          cardCVC: cardCVC,
        )
        .then((result) {
          result.fold(
            (error) {
              emit(MyBasketPaymentFailure(error));
            },
            (message) {
              emit(MyBasketPaymentSuccess(message));
            },
          );
        })
        .catchError((error) {
          emit(MyBasketPaymentFailure(error));
        });
  }
}
