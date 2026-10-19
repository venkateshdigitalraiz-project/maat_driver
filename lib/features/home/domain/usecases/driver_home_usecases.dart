import '../entities/driver_home_entities.dart';
import '../repositories/driver_home_repository.dart';

class GetDriverHomeDataUseCase {
  final DriverHomeRepository repository;

  const GetDriverHomeDataUseCase(this.repository);

  Future<DriverHomeDataEntity> call() async {
    return await repository.getDriverHomeData();
  }
}

class ToggleOnlineStatusUseCase {
  final DriverHomeRepository repository;

  const ToggleOnlineStatusUseCase(this.repository);

  Future<bool> call(bool targetStatus) async {
    return await repository.toggleOnlineStatus(targetStatus);
  }
}

class RespondToRideRequestUseCase {
  final DriverHomeRepository repository;

  const RespondToRideRequestUseCase(this.repository);

  Future<bool> accept(String requestId) async {
    return await repository.acceptRideRequest(requestId);
  }

  Future<bool> decline(String requestId) async {
    return await repository.declineRideRequest(requestId);
  }
}
