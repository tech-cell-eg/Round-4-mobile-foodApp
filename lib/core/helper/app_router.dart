import 'package:fruit_hub/features/autherntication_screen/presentation/views/authentication_view.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/views/registration_view.dart';
import 'package:fruit_hub/features/basket/presentation/views/my_basket_view.dart';
import 'package:fruit_hub/features/basket/presentation/views/order_complete_view.dart';
import 'package:fruit_hub/features/home/presentation/views/fruit_details_view.dart';
import 'package:fruit_hub/features/home/presentation/views/home_view.dart';
import 'package:fruit_hub/features/love_screen/presentation/views/love_view.dart';
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
        builder: (context, state) => AuthenticationView(),
      ),
      GoRoute(
        path: RegistrationView.kRegistrationView,
        name: "registration",
        builder: (context, state) => RegistrationView(),
      ),
      GoRoute(
        path: FruitDetailsView.kFruitDetailsView,
        name: "fruitDetails",
        builder: (context, state) => const FruitDetailsView(),
      ),
      GoRoute(
        path: LoveView.kLoveView,
        name: "love",
        builder: (context, state) => const LoveView(),
      ),
      GoRoute(
        path: OrderCompleteView.kOrderComplete,
        name: "completeOrder",
        builder: (context, state) => const OrderCompleteView(),
      ),
      GoRoute(
        path: MyBasketView.kMyBasketView,
        name: "basket",
        builder: (context, state) => const MyBasketView(),
      ),
      GoRoute(
        path: HomeView.kHomeView,
        name: "home",
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
