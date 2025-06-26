import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';
import 'package:fruit_hub/core/helper/app_validator.dart';
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/custom_text_field.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/registration_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository_impl.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/registration/registration_cubit.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/registration/registration_state.dart';
import 'package:go_router/go_router.dart';

class RegistrationView extends StatelessWidget {
  RegistrationView({super.key});
  static final String kRegistrationView = "/registration";

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => RegistrationCubit(
            AuthRepositoryImpl(RepositoryProvider.of<ApiHelper>(context)),
          ),
      child: Scaffold(
        backgroundColor: AppColors.orangeColor,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 80),
                Image.asset("assets/images/fruit_basket_2.png"),
                const SizedBox(height: 10),
                SvgPicture.asset('assets/images/shadow_fruit_2.svg'),
                const SizedBox(height: 24),
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
                          'Create your account',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle20.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Username',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle16.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          controller: _nameController,
                          hintText: "username",
                          validator: RequiredValidator(),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle16.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "email@example.com",
                          validator: EmailValidator(),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle16.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9+]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.grayColor,
                            prefix: const SizedBox(width: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            hintText: '0122155488',
                            hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: AppTextStyles.fontFamily,
                              color: AppColors.darkGrayColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle16.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "password",
                          validator: PasswordValidator(),
                          obscureText: true,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppTextStyles.textStyle16.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: "re-enter password",
                          validator: PasswordValidator(),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<RegistrationCubit, RegistrationState>(
                          listener: (context, state) {
                            if (state is RegistrationSuccess) {
                              CacheHelper.saveData(
                                key: CacheKeys.firstTime,
                                value: true,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registered successfully!'),
                                  backgroundColor:
                                      Colors
                                          .green, // Optional: change color to green
                                ),
                              );
                              context.goNamed('home');
                            } else if (state is RegistrationFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              text: 'Create Account',
                              isLoading: state is RegistrationLoading,
                              ontap: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<RegistrationCubit>()
                                      .registerUser(
                                        RegistrationEntity(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          passwordConfirmation:
                                              _confirmPasswordController.text,
                                          phoneNumber: _phoneController.text,
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
                              context.goNamed('Authontication');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: AppTextStyles.textStyle16.fontSize,
                                  color: AppColors.blackColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.orangeColor,
                                    ),
                                  ),
                                ],
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
