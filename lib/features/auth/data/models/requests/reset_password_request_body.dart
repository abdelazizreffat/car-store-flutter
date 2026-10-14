class ResetPasswordRequestBody {
  final String email;
  final String newPassword;
  const ResetPasswordRequestBody({
    required this.email,
    required this.newPassword,
  });
  Map<String, dynamic> toJson() => {'email': email, 'newPassword': newPassword};
}
