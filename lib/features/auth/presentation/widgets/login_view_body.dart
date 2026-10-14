import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/features/auth/presentation/widgets/auth_switch_prompt.dart';
import 'package:car_store/features/auth/presentation/widgets/login_form.dart';
import 'package:car_store/features/auth/presentation/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // TODO : add custom padding to AppStyle
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const LoginHeader(),
              const SizedBox(height: 36),
              LoginForm(
                onForgotPassword: (email) {
                  context.push(
                    '${AppRouter.kForgotPasswordView}?email=${Uri.encodeComponent(email)}',
                  );
                },
              ),
              const SizedBox(height: 20),
              AuthSwitchPrompt(
                text: AppStrings.dontHaveAccount,
                actionText: AppStrings.signUp,
                onPressed: () {
                  context.push(AppRouter.kSignUpView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
