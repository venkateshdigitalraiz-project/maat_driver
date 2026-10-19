import '../entities/captain_profile_entity.dart';

abstract class CaptainProfileRepository {
  Future<CaptainProfileEntity> getCaptainProfile();
  Future<bool> toggleCarpoolHost(bool isActive);
}
