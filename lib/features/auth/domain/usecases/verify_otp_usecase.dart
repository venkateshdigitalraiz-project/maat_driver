import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  const VerifyOtpUseCase(this.repository);

  Future<UserEntity> call({
    required String phoneNumber,
    required String otp,
  }) async {
    return await repository.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );
  }
}
