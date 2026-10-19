import '../entities/driver_home_entities.dart';

abstract class DriverHomeRepository {
  Future<DriverHomeDataEntity> getDriverHomeData();
  Future<bool> toggleOnlineStatus(bool targetStatus);
  Future<bool> acceptRideRequest(String requestId);
  Future<bool> declineRideRequest(String requestId);
}
