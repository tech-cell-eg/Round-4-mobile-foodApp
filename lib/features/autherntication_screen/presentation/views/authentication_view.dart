import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';
import 'package:fruit_hub/core/helper/app_validator.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/app_toast.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/custom_text_field.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/authentication_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository_impl.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/authentication/authentication_state.dart';
import 'package:go_router/go_router.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({super.key});
  static final String kAuthonticationView = "/Authontication";

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => LoginCubit(
            AuthRepositoryImpl(RepositoryProvider.of<ApiHelper>(context)),
          ),
      child: Scaffold(
        backgroundColor: AppColors.orangeColor,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 100),
                Image.asset("assets/images/fruit_basket_2.png"),
                const SizedBox(height: 10),
                SvgPicture.asset('assets/images/shadow_fruit_2.svg'),
                const SizedBox(height: 36),
              ]),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: AppColors.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your email',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle20.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "email@example.com",
                          validator: EmailValidator(),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Enter your password',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle20.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "password",
                          validator: PasswordValidator(),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),

                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              CacheHelper.saveData(
                                key: CacheKeys.firstTime,
                                value: true,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Welcome back, ${CacheData.userName}!',
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );

                              Future.delayed(const Duration(seconds: 1), () {
                                context.goNamed('home');
                              });
                            } else if (state is LoginFailure) {
                              AppToast.showErrorToast(state.errorMessage);
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              text: 'Start Ordering',
                              isLoading: state is LoginLoading,
                              ontap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await context.read<LoginCubit>().loginUser(
                                    LoginEntity(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      username: _usernameController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              context.goNamed('registration');
                            },
                            child: Text(
                              'Don\'t have an account? Sign Up',
                              style: TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: AppTextStyles.textStyle16.fontSize,
                                color: AppColors.orangeColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
