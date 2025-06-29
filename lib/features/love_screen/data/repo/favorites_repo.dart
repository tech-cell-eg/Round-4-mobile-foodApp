// features/favorites/data/repo/favorites_repo.dart
import 'package:dartz/dartz.dart';
import 'package:fruit_hub/features/love_screen/data/models/favorite_model.dart';

abstract class FavoritesRepo {
  Future<Either<String, List<FavoriteItem>>> getFavorites();
  Future<Either<String, String>> addToFavorites(int productId);
}
