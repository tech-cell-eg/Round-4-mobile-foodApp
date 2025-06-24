import 'package:fruit_hub/features/autherntication_screen/presentation/authentication_view.dart';
import 'package:fruit_hub/features/home/presentation/views/fruit_details_view.dart';
import 'package:fruit_hub/features/home/presentation/views/home_view.dart';
import 'package:fruit_hub/features/splash_screen/presentation/pages/splash_view.dart';
import 'package:fruit_hub/features/welcome_screen/presentation/pages/welcome_view.dart';
import 'package:go_router/go_router.dart';


abstract class AppRouter {
  static const kSplashView = '/';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: WelcomePage.kWelcomeView,
        name: "welcome",
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AuthenticationView.kAuthonticationView,
        name: "Authontication",
        builder: (context, state) => const AuthenticationView(),
      ),
      GoRoute(
        path: FruitDetailsView.kFruitDetailsView,
        name: "fruitDetails",
        builder: (context, state) => const FruitDetailsView(),
      ),
      GoRoute(
        path: HomeView.kHomeView,
        name: "home",
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
