import '../../domain/entities/captain_profile_entity.dart';

class CaptainProfileModel extends CaptainProfileEntity {
  const CaptainProfileModel({
    required super.id,
    required super.name,
    required super.captainId,
    required super.phoneNumber,
    required super.vehicleName,
    required super.vehicleNumber,
    required super.vehicleType,
    required super.rating,
    required super.totalRatings,
    required super.totalTrips,
    required super.acceptanceRate,
    required super.completionRate,
    required super.walletBalance,
    required super.documentsStatus,
    required super.carpoolHostActive,
  });

  factory CaptainProfileModel.fromJson(Map<String, dynamic> json) {
    return CaptainProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      captainId: json['captain_id'] as String,
      phoneNumber: json['phone_number'] as String,
      vehicleName: json['vehicle_name'] as String,
      vehicleNumber: json['vehicle_number'] as String,
      vehicleType: json['vehicle_type'] as String,
      rating: (json['rating'] as num).toDouble(),
      totalRatings: json['total_ratings'] as int,
      totalTrips: json['total_trips'] as int,
      acceptanceRate: (json['acceptance_rate'] as num).toDouble(),
      completionRate: (json['completion_rate'] as num).toDouble(),
      walletBalance: (json['wallet_balance'] as num).toDouble(),
      documentsStatus: json['documents_status'] as String,
      carpoolHostActive: json['carpool_host_active'] as bool? ?? false,
    );
  }
}
