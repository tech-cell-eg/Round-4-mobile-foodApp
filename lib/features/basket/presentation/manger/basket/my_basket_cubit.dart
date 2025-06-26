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
    shoppingCartRepo
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
}
