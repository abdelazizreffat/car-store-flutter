import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/google_sign_in/google_sign_in_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/auth_switch_prompt.dart';
import 'package:car_store/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:car_store/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:car_store/features/auth/presentation/widgets/sign_up_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoogleSignInCubit>(
      create: (_) => sl<GoogleSignInCubit>(),
      child: BlocListener<GoogleSignInCubit, GoogleSignInState>(
        listener: (context, state) {
          if (state is GoogleSignInSuccess) {
            context.read<AuthCubit>().setAuthenticated(state.user);
            context.go(AppRouter.kHomeView);
          }
          if (state is GoogleSignInError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const SignUpHeader(),
                  const SizedBox(height: 36),
                  const SignUpForm(),
                  const SizedBox(height: 16),
                  const GoogleSignInButton(),
                  const SizedBox(height: 20),
                  AuthSwitchPrompt(
                    text: AppStrings.alreadyHaveAccount,
                    actionText: AppStrings.signIn,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
