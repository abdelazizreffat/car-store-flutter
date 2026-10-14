import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/auth/presentation/cubits/verify_reset_otp/verify_reset_otp_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/verify_reset_otp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetOtpView extends StatelessWidget {
  final String email;
  const VerifyResetOtpView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VerifyResetOtpCubit>(),
      child: Scaffold(body: VerifyResetOtpViewBody(email: email)),
    );
  }
}
