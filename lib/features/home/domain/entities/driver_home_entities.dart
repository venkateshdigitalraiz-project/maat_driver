import 'package:equatable/equatable.dart';

class DriverEarningsStatsEntity extends Equatable {
  final double todayEarnings;
  final int completedTrips;
  final double onlineHours;
  final int dailyGoalCompleted;
  final int dailyGoalTarget;
  final double bonusReward;

  const DriverEarningsStatsEntity({
    required this.todayEarnings,
    required this.completedTrips,
    required this.onlineHours,
    required this.dailyGoalCompleted,
    required this.dailyGoalTarget,
    required this.bonusReward,
  });

  @override
  List<Object?> get props => [
        todayEarnings,
        completedTrips,
        onlineHours,
        dailyGoalCompleted,
        dailyGoalTarget,
        bonusReward,
      ];
}

class IncomingRideRequestEntity extends Equatable {
  final String id;
  final String passengerName;
  final double passengerRating;
  final String pickupAddress;
  final String dropAddress;
  final String pickupDistance;
  final String pickupEta;
  final double tripDistanceKm;
  final double fareAmount;
  final String serviceType; // Bike, Auto, Cab, Carpool
  final String paymentMode; // Cash, UPI, Wallet

  const IncomingRideRequestEntity({
    required this.id,
    required this.passengerName,
    required this.passengerRating,
    required this.pickupAddress,
    required this.dropAddress,
    required this.pickupDistance,
    required this.pickupEta,
    required this.tripDistanceKm,
    required this.fareAmount,
    required this.serviceType,
    required this.paymentMode,
  });

  @override
  List<Object?> get props => [
        id,
        passengerName,
        passengerRating,
        pickupAddress,
        dropAddress,
        pickupDistance,
        pickupEta,
        tripDistanceKm,
        fareAmount,
        serviceType,
        paymentMode,
      ];
}

class SurgeAreaEntity extends Equatable {
  final String areaName;
  final String multiplier;
  final String demandTag;

  const SurgeAreaEntity({
    required this.areaName,
    required this.multiplier,
    required this.demandTag,
  });

  @override
  List<Object?> get props => [areaName, multiplier, demandTag];
}

class DriverHomeDataEntity extends Equatable {
  final bool isOnline;
  final DriverEarningsStatsEntity stats;
  final IncomingRideRequestEntity? activeRequest;
  final List<SurgeAreaEntity> surgeAreas;

  const DriverHomeDataEntity({
    required this.isOnline,
    required this.stats,
    this.activeRequest,
    required this.surgeAreas,
  });

  @override
  List<Object?> get props => [isOnline, stats, activeRequest, surgeAreas];
}
