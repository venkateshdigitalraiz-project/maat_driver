import '../repositories/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository repository;

  const ResendOtpUseCase(this.repository);

  Future<bool> call({required String phoneNumber}) async {
    return await repository.resendOtp(phoneNumber: phoneNumber);
  }
}
