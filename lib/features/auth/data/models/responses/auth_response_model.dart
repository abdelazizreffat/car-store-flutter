import 'auth_data.dart';

class AuthResponseModel {
  final bool? success;
  final String? message;
  final AuthData? data;

  const AuthResponseModel({this.success, this.message, this.data});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}
