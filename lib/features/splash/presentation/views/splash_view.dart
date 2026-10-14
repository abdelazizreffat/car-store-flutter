import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _navigationStarted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthCubit>().checkSession();
      }
    });
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (_navigationStarted) return;

    if (state is AuthAuthenticated) {
      _navigationStarted = true;
      context.go(AppRouter.kHomeView);
      _removeNativeSplashAfterFrame();
    } else if (state is AuthUnauthenticated || state is AuthError) {
      _navigationStarted = true;
      context.go(AppRouter.kLoginView);
      _removeNativeSplashAfterFrame();
    }
  }

  void _removeNativeSplashAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: _handleAuthState,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: const SizedBox.expand(),
      ),
    );
  }
}
