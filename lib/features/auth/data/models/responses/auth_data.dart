import 'user_model.dart';

class AuthData {
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;

  const AuthData({this.user, this.accessToken, this.refreshToken});

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    accessToken: json['accessToken'] as String?,
    refreshToken: json['refreshToken'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };
}
