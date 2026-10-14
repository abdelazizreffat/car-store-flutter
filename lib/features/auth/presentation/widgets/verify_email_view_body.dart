import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/utils/validators.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/custom_text_field.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/verify_email/verify_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailViewBody extends StatefulWidget {
  final String email;

  const VerifyEmailViewBody({super.key, required this.email});

  @override
  State<VerifyEmailViewBody> createState() => _VerifyEmailViewBodyState();
}

class _VerifyEmailViewBodyState extends State<VerifyEmailViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerify() {
    if (!_formKey.currentState!.validate()) return;

    context.read<VerifyEmailCubit>().verifyEmail(
      email: widget.email,
      otp: _otpController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
      listener: (context, state) {
        if (state is VerifyEmailSuccess) {
          // Update global session state then navigate to home.
          context.read<AuthCubit>().setAuthenticated(state.user);
          context.go(AppRouter.kHomeView);
        }

        if (state is VerifyEmailError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is VerifyEmailLoading;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    AppStrings.verifyEmail,
                    style: AppStyles.textStyle20SemiBoldBlack,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppStrings.verifyEmailSubtitle} ${widget.email}',
                    style: AppStyles.textStyle14MediumDarkGrey,
                  ),
                  const SizedBox(height: 36),
                  CustomTextField(
                    labelText: AppStrings.otpCode,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: AppColors.grey,
                    labelStyle: AppStyles.textStyle16SemiBoldGray,
                    floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                    fillColor: AppColors.white,
                    hasShadow: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: Validators.otp,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    minHeight: 56,
                    isLoading: isLoading,
                    buttonLabel: AppStrings.verify,
                    onPressed: isLoading ? null : _onVerify,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
