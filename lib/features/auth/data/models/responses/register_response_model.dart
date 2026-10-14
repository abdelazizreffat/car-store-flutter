// Separate model for register response because it returns only email and firstName,
// unlike login/verify which return full user + tokens.
class RegisterResponseModel {
  final bool? success;
  final String? message;
  final RegisterResponseData? data;

  const RegisterResponseModel({this.success, this.message, this.data});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : RegisterResponseData.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      );
}

class RegisterResponseData {
  final String? email;
  final String? firstName;

  const RegisterResponseData({this.email, this.firstName});

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) =>
      RegisterResponseData(
        email: json['email'] as String?,
        firstName: json['firstName'] as String?,
      );
}
