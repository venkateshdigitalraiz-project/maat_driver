import 'dart:async';
import '../models/driver_home_models.dart';

abstract class DriverHomeRemoteDataSource {
  Future<DriverHomeDataModel> getDriverHomeData();
  Future<bool> toggleOnlineStatus(bool targetStatus);
  Future<bool> acceptRideRequest(String requestId);
  Future<bool> declineRideRequest(String requestId);
}

class DriverHomeRemoteDataSourceImpl implements DriverHomeRemoteDataSource {
  bool _isOnline = true;
  IncomingRideRequestModel? _activeRequest;

  DriverHomeRemoteDataSourceImpl() {
    _activeRequest = const IncomingRideRequestModel(
      id: 'req_88291',
      passengerName: 'Priya Sen',
      passengerRating: 4.88,
      pickupAddress: 'Indiranagar Metro, Gate 2',
      dropAddress: 'Koramangala 5th Block, Bengaluru',
      pickupDistance: '0.9 km',
      pickupEta: '2 mins away',
      tripDistanceKm: 5.6,
      fareAmount: 142.0,
      serviceType: '🛵 Bike Captain',
      paymentMode: 'Online Paid (UPI)',
    );
  }

  @override
  Future<DriverHomeDataModel> getDriverHomeData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    const stats = DriverEarningsStatsModel(
      todayEarnings: 1420.0,
      completedTrips: 8,
      onlineHours: 5.5,
      dailyGoalCompleted: 8,
      dailyGoalTarget: 11,
      bonusReward: 250.0,
    );

    final surgeAreas = [
      const SurgeAreaModel(
        areaName: 'Koramangala 5th Block',
        multiplier: '1.6x',
        demandTag: '🔥 High Surge',
      ),
      const SurgeAreaModel(
        areaName: 'Indiranagar 100ft Road',
        multiplier: '1.4x',
        demandTag: '⚡ High Demand',
      ),
      const SurgeAreaModel(
        areaName: 'Bellandur EcoSpace Tech',
        multiplier: '1.3x',
        demandTag: '📈 Peak Hours',
      ),
    ];

    return DriverHomeDataModel(
      isOnline: _isOnline,
      stats: stats,
      activeRequest: _isOnline ? _activeRequest : null,
      surgeAreas: surgeAreas,
    );
  }

  @override
  Future<bool> toggleOnlineStatus(bool targetStatus) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isOnline = targetStatus;
    return true;
  }

  @override
  Future<bool> acceptRideRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _activeRequest = null;
    return true;
  }

  @override
  Future<bool> declineRideRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _activeRequest = null;
    return true;
  }
}
