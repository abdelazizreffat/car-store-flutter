import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:car_store/features/auth/presentation/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => sl<RegisterCubit>(),
      child: const Scaffold(body: SignUpViewBody()),
    );
  }
}
