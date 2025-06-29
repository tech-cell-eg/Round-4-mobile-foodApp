// features/favorites/data/repo/favorites_repo_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/core/network/api_response.dart';
import 'package:fruit_hub/core/network/end_points.dart';
import 'package:fruit_hub/features/love_screen/data/models/favorite_model.dart';
import 'package:fruit_hub/features/love_screen/data/repo/favorites_repo.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  static final FavoritesRepoImpl _instance = FavoritesRepoImpl._internal();
  factory FavoritesRepoImpl() => _instance;
  FavoritesRepoImpl._internal();
  ApiHelper apiHelper = ApiHelper();

  @override
  Future<Either<String, List<FavoriteItem>>> getFavorites() async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: EndPoints.favorites,
        isProtected: true,
      );

      if (response.data != null) {
        FavoriteResponse favoriteResponse = FavoriteResponse.fromJson(
          response.data,
        );
        return Right(favoriteResponse.data);
      } else {
        return Left("Failed to load shopping cart ${response.message}");
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }

  @override
  Future<Either<String, String>> addToFavorites(int productId) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.favorites,
        data: {'product_id': productId},
        isProtected: true,
      );

      if (response.status) {
        return Right(response.message);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      debugPrint('Error in addToFavorites: $e');
      return Left('Failed to update favorite: ${e.toString()}');
    }
  }
}
