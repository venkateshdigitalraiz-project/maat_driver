import '../../../../core/errors/failures.dart';
import '../../domain/entities/captain_profile_entity.dart';
import '../../domain/repositories/captain_profile_repository.dart';
import '../datasources/captain_profile_remote_data_source.dart';

class CaptainProfileRepositoryImpl implements CaptainProfileRepository {
  final CaptainProfileRemoteDataSource remoteDataSource;

  const CaptainProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CaptainProfileEntity> getCaptainProfile() async {
    try {
      return await remoteDataSource.getCaptainProfile();
    } catch (e) {
      throw ServerFailure('Unable to load captain profile: $e');
    }
  }

  @override
  Future<bool> toggleCarpoolHost(bool isActive) async {
    try {
      return await remoteDataSource.toggleCarpoolHost(isActive);
    } catch (e) {
      throw ServerFailure('Unable to update carpool host mode: $e');
    }
  }
}
