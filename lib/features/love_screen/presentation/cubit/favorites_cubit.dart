// features/favorites/presentation/cubit/favorites_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/love_screen/data/repo/favorites_repo.dart';
import 'package:fruit_hub/features/love_screen/presentation/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo favoritesRepo;

  FavoritesCubit({required this.favoritesRepo}) : super(FavoritesInitial());
  static FavoritesCubit get(context) => BlocProvider.of(context);

  void getFavorites() async {
    emit(FavoritesLoading());
    final response = await favoritesRepo.getFavorites();
    response.fold(
      (error) => emit(FavoritesError(error)),
      (data) => emit(FavoritesLoaded(data)),
    );
  }

  Future<void> toggleFavorite(int productId) async {
    final response = await favoritesRepo.addToFavorites(productId);
    response.fold((error) => emit(FavoritesError(error)), (message) {
      getFavorites(); // Refresh list
      emit(FavoritesMessage(message));
    });
  }
}
