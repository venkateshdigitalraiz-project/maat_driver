import '../../domain/entities/driver_home_entities.dart';

class DriverEarningsStatsModel extends DriverEarningsStatsEntity {
  const DriverEarningsStatsModel({
    required super.todayEarnings,
    required super.completedTrips,
    required super.onlineHours,
    required super.dailyGoalCompleted,
    required super.dailyGoalTarget,
    required super.bonusReward,
  });

  factory DriverEarningsStatsModel.fromJson(Map<String, dynamic> json) {
    return DriverEarningsStatsModel(
      todayEarnings: (json['today_earnings'] as num).toDouble(),
      completedTrips: json['completed_trips'] as int,
      onlineHours: (json['online_hours'] as num).toDouble(),
      dailyGoalCompleted: json['daily_goal_completed'] as int,
      dailyGoalTarget: json['daily_goal_target'] as int,
      bonusReward: (json['bonus_reward'] as num).toDouble(),
    );
  }
}

class IncomingRideRequestModel extends IncomingRideRequestEntity {
  const IncomingRideRequestModel({
    required super.id,
    required super.passengerName,
    required super.passengerRating,
    required super.pickupAddress,
    required super.dropAddress,
    required super.pickupDistance,
    required super.pickupEta,
    required super.tripDistanceKm,
    required super.fareAmount,
    required super.serviceType,
    required super.paymentMode,
  });

  factory IncomingRideRequestModel.fromJson(Map<String, dynamic> json) {
    return IncomingRideRequestModel(
      id: json['id'] as String,
      passengerName: json['passenger_name'] as String,
      passengerRating: (json['passenger_rating'] as num).toDouble(),
      pickupAddress: json['pickup_address'] as String,
      dropAddress: json['drop_address'] as String,
      pickupDistance: json['pickup_distance'] as String,
      pickupEta: json['pickup_eta'] as String,
      tripDistanceKm: (json['trip_distance_km'] as num).toDouble(),
      fareAmount: (json['fare_amount'] as num).toDouble(),
      serviceType: json['service_type'] as String,
      paymentMode: json['payment_mode'] as String,
    );
  }
}

class SurgeAreaModel extends SurgeAreaEntity {
  const SurgeAreaModel({
    required super.areaName,
    required super.multiplier,
    required super.demandTag,
  });

  factory SurgeAreaModel.fromJson(Map<String, dynamic> json) {
    return SurgeAreaModel(
      areaName: json['area_name'] as String,
      multiplier: json['multiplier'] as String,
      demandTag: json['demand_tag'] as String,
    );
  }
}

class DriverHomeDataModel extends DriverHomeDataEntity {
  const DriverHomeDataModel({
    required super.isOnline,
    required super.stats,
    super.activeRequest,
    required super.surgeAreas,
  });
}
