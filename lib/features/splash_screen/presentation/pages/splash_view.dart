import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';
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

  Future<void> _checkAuthStatus() async {
    try {
      await CacheHelper.init();

      await Future.delayed(const Duration(milliseconds: 2));
      if (!mounted) return;

      CacheData.firstTime = CacheHelper.getData(key: CacheKeys.firstTime);

      if (CacheData.firstTime == null || CacheData.firstTime == true) {
        context.goNamed('welcome');
      } else {
        CacheData.accessToken = CacheHelper.getData(key: CacheKeys.accessToken);
        if (CacheData.accessToken != null) {
          context.goNamed('home');
        } else {
          context.goNamed('welcome');
        }
      }
    } catch (e) {
      if (mounted) {
        context.goNamed('welcome');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/images/fruit_hub_icon.svg')),
    );
  }
}
