import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => sl<LoginCubit>(),
      child: const Scaffold(body: LoginViewBody()),
    );
  }
}
