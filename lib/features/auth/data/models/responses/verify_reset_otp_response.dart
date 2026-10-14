// Separate model because verify-reset-otp returns a resetToken, not auth tokens.
class VerifyResetOtpResponse {
  final bool? success;
  final String? message;
  final VerifyResetOtpData? data;

  const VerifyResetOtpResponse({this.success, this.message, this.data});

  factory VerifyResetOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyResetOtpResponse(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : VerifyResetOtpData.fromJson(json['data'] as Map<String, dynamic>),
      );
}

class VerifyResetOtpData {
  final String? resetToken;
  const VerifyResetOtpData({this.resetToken});

  factory VerifyResetOtpData.fromJson(Map<String, dynamic> json) =>
      VerifyResetOtpData(resetToken: json['resetToken'] as String?);
}
