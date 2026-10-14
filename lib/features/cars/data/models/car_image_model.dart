class CarImageModel {
  final String? id;
  final String? url;
  final bool? isPrimary;
  final int? order;

  const CarImageModel({
    this.id,
    this.url,
    this.isPrimary,
    this.order,
  });

  factory CarImageModel.fromJson(Map<String, dynamic> json) {
    return CarImageModel(
      id: json['id'] as String?,
      url: json['url'] as String?,
      isPrimary: json['isPrimary'] as bool?,
      order: json['order'] as int?,
    );
  }
}