import 'package:equatable/equatable.dart';

class CaptainProfileEntity extends Equatable {
  final String id;
  final String name;
  final String captainId;
  final String phoneNumber;
  final String vehicleName;
  final String vehicleNumber;
  final String vehicleType; // Bike, Auto, Cab, Carpool
  final double rating;
  final int totalRatings;
  final int totalTrips;
  final double acceptanceRate;
  final double completionRate;
  final double walletBalance;
  final String documentsStatus;
  final bool carpoolHostActive;

  const CaptainProfileEntity({
    required this.id,
    required this.name,
    required this.captainId,
    required this.phoneNumber,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.rating,
    required this.totalRatings,
    required this.totalTrips,
    required this.acceptanceRate,
    required this.completionRate,
    required this.walletBalance,
    required this.documentsStatus,
    required this.carpoolHostActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        captainId,
        phoneNumber,
        vehicleName,
        vehicleNumber,
        vehicleType,
        rating,
        totalRatings,
        totalTrips,
        acceptanceRate,
        completionRate,
        walletBalance,
        documentsStatus,
        carpoolHostActive,
      ];
}
