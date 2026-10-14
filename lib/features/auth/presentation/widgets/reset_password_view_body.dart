import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/utils/validators.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/custom_text_field.dart';
import 'package:car_store/core/widgets/show_password_checkbox.dart';
import 'package:car_store/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordViewBody extends StatefulWidget {
  final String email;

  const ResetPasswordViewBody({super.key, required this.email});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onReset() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ResetPasswordCubit>().resetPassword(
      email: widget.email,
      newPassword: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          context.go(AppRouter.kLoginView);
        }
        if (state is ResetPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;
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
                    AppStrings.resetPasswordTitle,
                    style: AppStyles.textStyle20SemiBoldBlack,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.resetPasswordSubtitle,
                    style: AppStyles.textStyle14RegularBlack,
                  ),
                  const SizedBox(height: 36),
                  CustomTextField(
                    labelText: AppStrings.newPassword,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: AppColors.grey,
                    isObscureText: !_showPassword,
                    labelStyle: AppStyles.textStyle16SemiBoldGray,
                    floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                    fillColor: AppColors.white,
                    hasShadow: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    labelText: AppStrings.confirmNewPassword,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: AppColors.grey,
                    isObscureText: !_showPassword,
                    labelStyle: AppStyles.textStyle16SemiBoldGray,
                    floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                    fillColor: AppColors.white,
                    hasShadow: true,
                    validator: (value) {
                      return Validators.confirmPassword(
                        value,
                        _passwordController.text,
                      );
                    },
                  ),
                  ShowPasswordCheckbox(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    minHeight: 56,
                    isLoading: isLoading,
                    buttonLabel: AppStrings.resetPassword,
                    onPressed: isLoading ? null : _onReset,
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
