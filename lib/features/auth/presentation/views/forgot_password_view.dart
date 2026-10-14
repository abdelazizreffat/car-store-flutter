import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/auth/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  final String prefillEmail;

  const ForgotPasswordView({super.key, this.prefillEmail = ''});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgotPasswordCubit>(),
      child: Scaffold(body: ForgotPasswordViewBody(prefillEmail: prefillEmail)),
    );
  }
}
