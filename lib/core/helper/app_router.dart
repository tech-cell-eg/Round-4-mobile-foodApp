import 'package:fruit_hub/features/home/presentation/views/fruit_details_view.dart';
import 'package:fruit_hub/features/splash/presentation/pages/splash_page.dart';
import 'package:fruit_hub/features/welcome_page/presentation/pages/welcome_page.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kHomeView = '/';

  static final router = GoRouter(
    routes: [
      // GoRoute(
      //   path: kHomeView,
      //   builder: (context, state) => const HomeView(),
      // ),
      GoRoute(path: kHomeView, builder: (context, state) => const SplashPage()),
      GoRoute(
        path: WelcomePage.kWelcomeView,
        name: "welcome",
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: FruitDetailsView.kFruitDetailsView,
        name: "fruitDetails",
        builder: (context, state) => const FruitDetailsView(),
      ),
    ],
  );
}
