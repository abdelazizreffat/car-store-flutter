import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/auth/presentation/cubits/verify_email/verify_email_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/verify_email_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatelessWidget {
  final String email;

  const VerifyEmailView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyEmailCubit>(
      create: (_) => sl<VerifyEmailCubit>(),
      child: Scaffold(body: VerifyEmailViewBody(email: email)),
    );
  }
}
