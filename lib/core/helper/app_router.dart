import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kHomeView = '/HomeView';

  static final router = GoRouter(
    routes: [
      // GoRoute(
      //   path: kHomeView,
      //   builder: (context, state) => const HomeView(),
      // ),
    ],
  );
}