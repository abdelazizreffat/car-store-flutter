import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/reset_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  final String email;

  const ResetPasswordView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ResetPasswordCubit>(),
      child: Scaffold(body: ResetPasswordViewBody(email: email)),
    );
  }
}
