import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/go_back_icon.dart';
import 'package:fruit_hub/features/love_screen/data/repo/favorites_repo_imp.dart';
import 'package:fruit_hub/features/love_screen/presentation/cubit/favorites_cubit.dart';
import 'package:fruit_hub/features/love_screen/presentation/widgets/love_view_body.dart';
import 'package:go_router/go_router.dart';

class LoveView extends StatelessWidget {
  const LoveView({super.key});
  static final String kLoveView = "/love";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(favoritesRepo: FavoritesRepoImpl()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: Container(
            height: 150,
            color: AppColors.orangeColor,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Row(
                children: [
                  GoBackIcon(),
                  const SizedBox(width: 70),
                  Text(
                    'Love page',
                    style: AppTextStyles.textStyle24.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_basket,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        context.pushNamed('basket');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: LoveViewBody(),
      ),
    );
  }
}
