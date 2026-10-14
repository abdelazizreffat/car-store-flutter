class CarSellerModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? phone;

  const CarSellerModel({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.phone,
  });

  factory CarSellerModel.fromJson(Map<String, dynamic> json) {
    return CarSellerModel(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
    );
  }

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}