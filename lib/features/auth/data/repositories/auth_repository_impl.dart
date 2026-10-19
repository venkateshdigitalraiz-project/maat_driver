import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> sendOtp({required String phoneNumber}) async {
    try {
      return await remoteDataSource.sendOtp(phoneNumber: phoneNumber);
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final userModel = await remoteDataSource.verifyOtp(
        phoneNumber: phoneNumber,
        otp: otp,
      );
      return userModel;
    } on InvalidOtpException catch (e) {
      throw InvalidOtpFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<bool> resendOtp({required String phoneNumber}) async {
    try {
      return await remoteDataSource.resendOtp(phoneNumber: phoneNumber);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
