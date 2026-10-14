import 'package:car_store/core/constants/app_assets.dart';
import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/features/auth/presentation/cubits/google_sign_in/google_sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleSignInCubit, GoogleSignInState>(
      builder: (context, state) {
        final isLoading = state is GoogleSignInLoading;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(color: AppColors.grey, thickness: 1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Or',
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ),
                const Expanded(
                  child: Divider(color: AppColors.grey, thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Sign Up with',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            IconButton(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(AppColors.primary),
                overlayColor: WidgetStatePropertyAll(
                  AppColors.primary.withValues(alpha: 0.12),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () => context.read<GoogleSignInCubit>().signInWithGoogle(),
              icon: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 2.5,
                      ),
                    )
                  : SvgPicture.asset(
                      AppAssets.googleLogo,
                      width: 28,
                      height: 28,
                    ),
              tooltip: AppStrings.continueWithGoogle,
            ),
          ],
        );
      },
    );
  }
}
