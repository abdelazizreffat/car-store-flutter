import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/utils/validators.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/custom_text_field.dart';
import 'package:car_store/features/auth/presentation/cubits/verify_reset_otp/verify_reset_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyResetOtpViewBody extends StatefulWidget {
  final String email;
  const VerifyResetOtpViewBody({super.key, required this.email});

  @override
  State<VerifyResetOtpViewBody> createState() => _VerifyResetOtpViewBodyState();
}

class _VerifyResetOtpViewBodyState extends State<VerifyResetOtpViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerify() {
    if (!_formKey.currentState!.validate()) return;
    context.read<VerifyResetOtpCubit>().verifyOtp(
      email: widget.email,
      otp: _otpController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyResetOtpCubit, VerifyResetOtpState>(
      listener: (context, state) {
        if (state is VerifyResetOtpSuccess) {
          context.push(
            '${AppRouter.kResetPasswordView}?email=${Uri.encodeQueryComponent(state.email)}',
          );
        }
        if (state is VerifyResetOtpError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is VerifyResetOtpLoading;
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    AppStrings.verifyResetOtp,
                    style: AppStyles.textStyle20SemiBoldBlack,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.verifyResetOtpSubtitle,
                    style: AppStyles.textStyle14RegularBlack,
                  ),
                  const SizedBox(height: 36),
                  CustomTextField(
                    labelText: AppStrings.otpCode,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    labelStyle: AppStyles.textStyle16SemiBoldGray,
                    floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                    fillColor: AppColors.white,
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: AppColors.grey,
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
                    buttonLabel: 'Verify OTP',
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
