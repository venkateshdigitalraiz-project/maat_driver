import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Sends a 4-digit OTP to the specified [phoneNumber].
  Future<bool> sendOtp({required String phoneNumber});

  /// Verifies the 4-digit [otp] sent to [phoneNumber].
  Future<UserEntity> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  /// Resends the OTP to the specified [phoneNumber].
  Future<bool> resendOtp({required String phoneNumber});
}
