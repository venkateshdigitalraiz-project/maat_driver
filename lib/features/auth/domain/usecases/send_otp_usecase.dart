import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  const SendOtpUseCase(this.repository);

  Future<bool> call({required String phoneNumber}) async {
    return await repository.sendOtp(phoneNumber: phoneNumber);
  }
}
