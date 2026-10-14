class UserModel {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatar;
  final String? avatarPublicId;
  final String? authProvider;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;
  final String? role;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatar,
    this.avatarPublicId,
    this.authProvider,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.role,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    email: json['email'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    phone: json['phone'] as String?,
    avatar: json['avatar'] as String?,
    avatarPublicId: json['avatarPublicId'] as String?,
    authProvider: json['authProvider'] as String?,
    isEmailVerified: json['isEmailVerified'] as bool?,
    isPhoneVerified: json['isPhoneVerified'] as bool?,
    role: json['role'] as String?,
    isActive: json['isActive'] as bool?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'avatar': avatar,
    'avatarPublicId': avatarPublicId,
    'authProvider': authProvider,
    'isEmailVerified': isEmailVerified,
    'isPhoneVerified': isPhoneVerified,
    'role': role,
    'isActive': isActive,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
