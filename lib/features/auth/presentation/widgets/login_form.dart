import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/utils/validators.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/custom_text_field.dart';
import 'package:car_store/core/widgets/show_password_checkbox.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email)? onForgotPassword;

  const LoginForm({super.key, this.onForgotPassword});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    // Triggers all validators and shows red borders + messages if invalid.
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.read<AuthCubit>().setAuthenticated(state.user);
          context.go(AppRouter.kHomeView);
        }
        if (state is LoginEmailNotVerified) {
          context.go('${AppRouter.kVerifyEmailView}?email=${state.email}');
        }
        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              // TODO: Consider extracting reusable EmailTextField and PasswordTextField widgets to reduce repeated form configuration.
              CustomTextField(
                labelText: AppStrings.emailAddress,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                labelStyle: AppStyles.textStyle16SemiBoldGray,
                floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                fillColor: AppColors.white,
                prefixIcon: Icons.email_outlined,
                prefixIconColor: AppColors.grey,
                hasShadow: true,
                validator: Validators.email,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                labelText: AppStrings.password,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock_outline,
                prefixIconColor: AppColors.grey,
                isObscureText: !_showPassword,
                labelStyle: AppStyles.textStyle16SemiBoldGray,
                floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                fillColor: AppColors.white,
                hasShadow: true,
                validator: Validators.password,
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShowPasswordCheckbox(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = value;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () => widget.onForgotPassword?.call(
                      _emailController.text.trim(),
                    ),
                    child: Text(
                      AppStrings.forgotPassword,
                      style: AppStyles.textStyle14MediumPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              CustomButton(
                minHeight: 56,
                isLoading: isLoading,
                buttonLabel: AppStrings.login,
                onPressed: isLoading ? null : _onLogin,
              ),
            ],
          ),
        );
      },
    );
  }
}
