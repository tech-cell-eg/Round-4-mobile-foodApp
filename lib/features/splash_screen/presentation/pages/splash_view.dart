import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';
import 'package:fruit_hub/features/home/presentation/views/home_view.dart';
import 'package:fruit_hub/features/welcome_screen/presentation/pages/welcome_view.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(microseconds: 500)).then((value) {
      CacheData.firstTime = CacheHelper.getData(key: CacheKeys.firstTime);
      if (CacheData.firstTime != null) {
        CacheData.accessToken = CacheHelper.getData(key: CacheKeys.accessToken);
        CacheData.userName = CacheHelper.getData(key: CacheKeys.userName);
        if (CacheData.accessToken != null && CacheData.userName != null) {
          GoRouter.of(context).pushReplacement(HomeView.kHomeView);
        }
      } else {
        GoRouter.of(context).pushReplacement(WelcomePage.kWelcomeView);
      }
    },) ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/images/fruit_hub_icon.svg')),
    );
  }
}
