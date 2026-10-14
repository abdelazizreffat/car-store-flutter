class VerifyResetOtpRequestBody {
  final String email;
  final String otp;
  const VerifyResetOtpRequestBody({required this.email, required this.otp});
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}
