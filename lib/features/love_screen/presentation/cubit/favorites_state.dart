import 'package:fruit_hub/features/love_screen/data/models/favorite_model.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<FavoriteItem> favorites;
  FavoritesLoaded(this.favorites);
}

final class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

final class FavoritesMessage extends FavoritesState {
  final String message;
  FavoritesMessage(this.message);
}
