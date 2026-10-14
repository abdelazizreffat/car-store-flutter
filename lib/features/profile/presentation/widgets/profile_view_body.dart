import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          AppStrings.profile,
          style: AppStyles.textStyle20SemiBoldPrimary,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final UserModel? user = state is AuthAuthenticated
              ? state.user
              : null;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Avatar
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  backgroundImage: user?.avatar != null
                      ? NetworkImage(user!.avatar!)
                      : null,
                  child: user?.avatar == null
                      ? Text(
                          _initials(user),
                          style: AppStyles.textStyle28BoldWhite.copyWith(
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              Center(
                child: Text(
                  _fullName(user),
                  style: AppStyles.textStyle20SemiBoldBlack,
                ),
              ),

              // Email
              if (user?.email != null) ...[
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    user!.email!,
                    style: AppStyles.textStyle14MediumDarkGrey,
                  ),
                ),
              ],

              const SizedBox(height: 32),
              const Divider(),

              // Info rows
              _InfoRow(
                icon: Icons.email_outlined,
                label: AppStrings.emailAddress,
                value: user?.email ?? AppStrings.notAvailable,
              ),
              _InfoRow(
                icon: Icons.phone_outlined,
                label: AppStrings.phoneNumber,
                value: user?.phone ?? AppStrings.notAvailable,
              ),
              _InfoRow(
                icon: Icons.verified_outlined,
                label: 'Email Verified',
                value: (user?.isEmailVerified == true) ? 'Yes' : 'No',
              ),
              if (user?.createdAt != null)
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: AppStrings.memberSince,
                  value:
                      '${user!.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.year}',
                ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),

              // Logout button
              OutlinedButton.icon(
                onPressed: () => _confirmLogout(context),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  AppStrings.logout,
                  style: const TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  side: BorderSide.none,
                  minimumSize: const Size(double.infinity, 52),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppStyles.borderRadiusCircular10,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _initials(UserModel? user) {
    final first = user?.firstName?.isNotEmpty == true
        ? user!.firstName![0].toUpperCase()
        : '';
    final last = user?.lastName?.isNotEmpty == true
        ? user!.lastName![0].toUpperCase()
        : '';
    return '$first$last'.isNotEmpty ? '$first$last' : '?';
  }

  String _fullName(UserModel? user) {
    final name = '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim();
    return name.isNotEmpty ? name : AppStrings.notAvailable;
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          AppStrings.logout,
          style: AppStyles.textStyle20SemiBoldBlack,
        ),
        content: Text(AppStrings.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              AppStrings.cancel,
              style: const TextStyle(color: AppColors.darkGrey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AuthCubit>().logout();
            },
            child: Text(
              AppStrings.logout,
              style: const TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(label, style: AppStyles.textStyle14MediumDarkGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: AppStyles.textStyle14MediumBlack,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
