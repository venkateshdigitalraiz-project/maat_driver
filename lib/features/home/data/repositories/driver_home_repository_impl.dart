import '../../../../core/errors/failures.dart';
import '../../domain/entities/driver_home_entities.dart';
import '../../domain/repositories/driver_home_repository.dart';
import '../datasources/driver_home_remote_data_source.dart';

class DriverHomeRepositoryImpl implements DriverHomeRepository {
  final DriverHomeRemoteDataSource remoteDataSource;

  const DriverHomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DriverHomeDataEntity> getDriverHomeData() async {
    try {
      return await remoteDataSource.getDriverHomeData();
    } catch (e) {
      throw ServerFailure('Unable to load driver data: $e');
    }
  }

  @override
  Future<bool> toggleOnlineStatus(bool targetStatus) async {
    try {
      return await remoteDataSource.toggleOnlineStatus(targetStatus);
    } catch (e) {
      throw ServerFailure('Unable to switch online status: $e');
    }
  }

  @override
  Future<bool> acceptRideRequest(String requestId) async {
    try {
      return await remoteDataSource.acceptRideRequest(requestId);
    } catch (e) {
      throw ServerFailure('Failed to accept ride: $e');
    }
  }

  @override
  Future<bool> declineRideRequest(String requestId) async {
    try {
      return await remoteDataSource.declineRideRequest(requestId);
    } catch (e) {
      throw ServerFailure('Failed to decline ride: $e');
    }
  }
}
