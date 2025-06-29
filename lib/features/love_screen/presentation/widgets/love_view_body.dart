// features/favorites/presentation/views/love_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/utils/app_toast.dart';
import 'package:fruit_hub/core/utils/widgets/custom_app_loading.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';
import 'package:fruit_hub/features/love_screen/data/models/favorite_model.dart';
import 'package:fruit_hub/features/love_screen/presentation/cubit/favorites_cubit.dart';
import 'package:fruit_hub/features/love_screen/presentation/cubit/favorites_state.dart';
import 'package:fruit_hub/features/love_screen/presentation/widgets/custom_fruit_item.dart';

class LoveViewBody extends StatefulWidget {
  const LoveViewBody({super.key});

  @override
  State<LoveViewBody> createState() => _LoveViewBodyState();
}

class _LoveViewBodyState extends State<LoveViewBody> {
  @override
  void initState() {
    super.initState();
    FavoritesCubit.get(context).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesError) {
          AppToast.showErrorToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          return _buildFavoritesList(state.favorites);
        } else {
          return CustomAppLoading();
        }
      },
    );
  }

  Widget _buildFavoritesList(List<FavoriteItem> favorites) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        itemCount: favorites.length,
        separatorBuilder: (_, __) => const MyDivider(),
        itemBuilder:
            (context, index) =>
                FavoritItem(item: favorites[index], onAddPressed: () {}),
      ),
    );
  }
}
