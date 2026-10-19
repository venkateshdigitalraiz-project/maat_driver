import '../entities/captain_profile_entity.dart';
import '../repositories/captain_profile_repository.dart';

class GetCaptainProfileUseCase {
  final CaptainProfileRepository repository;

  const GetCaptainProfileUseCase(this.repository);

  Future<CaptainProfileEntity> call() async {
    return await repository.getCaptainProfile();
  }
}

class ToggleCarpoolHostUseCase {
  final CaptainProfileRepository repository;

  const ToggleCarpoolHostUseCase(this.repository);

  Future<bool> call(bool isActive) async {
    return await repository.toggleCarpoolHost(isActive);
  }
}
