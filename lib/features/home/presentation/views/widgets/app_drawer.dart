import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/logout/logoutcubit.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/logout/logoutstate.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(right: BorderSide(color: Colors.grey, width: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    CacheData.userName ?? 'Guest',
                    style: AppTextStyles.textStyle24,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      leading: const Icon(Icons.favorite, size: 20),
                      title: Text(
                        'Favorites',
                        style: AppTextStyles.textStyle20,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.pushNamed('love');
                      },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      leading: const Icon(Icons.shopping_basket, size: 20),
                      title: Text('Basket', style: AppTextStyles.textStyle20),
                      onTap: () {
                        Navigator.pop(context);
                        context.pushNamed('basket');
                      },
                    ),
                  ],
                ),
              ),

              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LogoutSuccess) {
                    // Navigate to authentication screen after successful logout
                    context.goNamed('Authontication');
                  } else if (state is AuthError) {
                    // Show error message if logout fails
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: const Icon(Icons.logout, size: 20),
                  title: Text('Logout', style: AppTextStyles.textStyle20),
                  onTap: () {
                    context.goNamed('Authontication');
                    context.read<AuthCubit>().userLogout();
                  },
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
