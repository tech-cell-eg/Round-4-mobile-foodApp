import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/helper/app_router.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ApiHelper()),
        RepositoryProvider(
          create:
              (context) =>
                  AuthRepositoryImpl(RepositoryProvider.of<ApiHelper>(context)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
