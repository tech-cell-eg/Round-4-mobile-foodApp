import 'package:fruit_hub/features/autherntication_screen/presentation/authentication_view.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/my_basket_view_body.dart';
import 'package:fruit_hub/features/basket/presentation/views/widgets/order_complete_view_body.dart';
import 'package:fruit_hub/features/home/presentation/views/fruit_details_view.dart';
import 'package:fruit_hub/features/home/presentation/views/home_view.dart';
import 'package:fruit_hub/features/splash_screen/presentation/pages/splash_view.dart';
import 'package:fruit_hub/features/welcome_screen/presentation/pages/welcome_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/basket/presentation/views/my_basket_view.dart';
import '../../features/basket/presentation/views/order_complete_view.dart';


abstract class AppRouter {
  static const kSplashView = '/';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const MyBasketView(),
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
      GoRoute(
        path: OrderCompleteViewBody.kOrderComplete,
        name: "complete order",
        builder: (context, state) => const OrderCompleteView(),
      ),
    ],
  );
}
