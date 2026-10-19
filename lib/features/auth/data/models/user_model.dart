import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.phoneNumber,
    super.name,
    super.token,
    super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? 'usr_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: json['phone_number'] as String? ?? '',
      name: json['name'] as String?,
      token: json['token'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'name': name,
      'token': token,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
