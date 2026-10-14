import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/utils/validators.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/custom_text_field.dart';
import 'package:car_store/core/widgets/show_password_checkbox.dart';
import 'package:car_store/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegisterCubit>().register(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.go('${AppRouter.kVerifyEmailView}?email=${state.email}');
        }
        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: AppStrings.fullName,
                controller: _fullNameController,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                labelStyle: AppStyles.textStyle16SemiBoldGray,
                floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                fillColor: AppColors.white,
                prefixIconColor: AppColors.grey,
                hasShadow: true,
                validator: Validators.fullName,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                labelText: AppStrings.emailAddress,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                labelStyle: AppStyles.textStyle16SemiBoldGray,
                floatingLabelStyle: AppStyles.textStyle18SemiBoldPrimary,
                fillColor: AppColors.white,
                prefixIconColor: AppColors.grey,
                hasShadow: true,
                validator: Validators.email,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                labelText: AppStrings.password,
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
                labelText: AppStrings.confirmPassword,
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
              const SizedBox(height: 8),
              ShowPasswordCheckbox(
                value: _showPassword,
                onChanged: (value) {
                  setState(() {
                    _showPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              CustomButton(
                minHeight: 56,
                isLoading: isLoading,
                buttonLabel: AppStrings.signUp,
                onPressed: isLoading ? null : _onRegister,
              ),
            ],
          ),
        );
      },
    );
  }
}
