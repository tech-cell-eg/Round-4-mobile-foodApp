import 'package:fruit_hub/features/home/presentation/views/fruit_details_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kHomeView = '/HomeView';
  static const kFruitDetailsView = '/';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kFruitDetailsView,
        builder: (context, state) => const FruitDetailsView(),
      ),
    ],
  );
}