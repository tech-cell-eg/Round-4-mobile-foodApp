part of 'my_basket_cubit.dart';

@immutable
sealed class MyBasketState {}

final class MyBasketInitial extends MyBasketState {}

final class MyBasketLoading extends MyBasketState {}

final class MyBasketLoaded extends MyBasketState {
  final List<Item> items;

  MyBasketLoaded(this.items);
}

final class MyBasketError extends MyBasketState {
  final String error;

  MyBasketError(this.error);
}
