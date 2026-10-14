import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/utils/validators.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/custom_text_field.dart';
import 'package:car_store/features/auth/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  final String prefillEmail;

  const ForgotPasswordViewBody({super.key, this.prefillEmail = ''});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Prefill with email from Login screen if available; remains editable.
    _emailController = TextEditingController(text: widget.prefillEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ForgotPasswordCubit>().sendOtp(_emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordOtpSent) {
          context.push(
            '${AppRouter.kVerifyResetOtpView}?email=${Uri.encodeQueryComponent(state.email)}',
          );
        }
        if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;
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
                    AppStrings.forgotPassword,
                    style: AppStyles.textStyle20SemiBoldBlack,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.forgotPasswordSubtitle,
                    style: AppStyles.textStyle14RegularBlack,
                  ),
                  const SizedBox(height: 36),
                  CustomTextField(
                    labelText: AppStrings.emailAddress,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelStyle: AppStyles.textStyle16SemiBoldGray,
                    floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                    fillColor: AppColors.white,
                    prefixIcon: Icons.email_outlined,
                    prefixIconColor: AppColors.grey,
                    hasShadow: true,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    minHeight: 56,
                    isLoading: isLoading,
                    buttonLabel: 'Send OTP',
                    onPressed: isLoading ? null : _onSendOtp,
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
