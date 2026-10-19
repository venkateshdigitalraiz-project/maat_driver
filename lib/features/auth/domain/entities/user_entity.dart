import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? token;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.token,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, phoneNumber, name, token, createdAt];
}
