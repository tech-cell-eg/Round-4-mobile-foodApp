import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/helper/app_router.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository_impl.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/usecases/logout.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/logout/logoutcubit.dart';
import 'package:fruit_hub/features/home/domain/repositories/product_repository_impl.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';

import 'features/basket/data/repo/shopping_cart_repo_implemation.dart';
import 'features/basket/presentation/manger/basket/my_basket_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create:
        (context) => ProductDetailsCubit(productRepository: ProductRepositoryImpl(apiHelper: ApiHelper()))),
        BlocProvider(
          create:
              (context) =>
                  MyBasketCubit(ShoppingCartRepoImplementation())
        ),
        BlocProvider<AuthCubit>(
          create:
              (context) => AuthCubit(
                logout: Logout(authRepository: AuthRepositoryImpl(ApiHelper())),
              ),
        ),
        RepositoryProvider(create: (_) => ApiHelper()),
        RepositoryProvider(
          create:
              (context) =>
                  AuthRepositoryImpl(RepositoryProvider.of<ApiHelper>(context)),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
