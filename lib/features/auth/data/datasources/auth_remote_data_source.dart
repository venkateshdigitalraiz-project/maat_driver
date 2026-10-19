import 'dart:async';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> sendOtp({required String phoneNumber});
  Future<UserModel> verifyOtp({required String phoneNumber, required String otp});
  Future<bool> resendOtp({required String phoneNumber});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Demo valid OTP for testing. Accepts "1234" or any 4-digit string in test mode
  // If user enters "0000", we can simulate an invalid OTP error to demonstrate error handling!
  static const String demoOtp = '1234';

  @override
  Future<bool> sendOtp({required String phoneNumber}) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 1200));

    // Basic sanity check
    if (phoneNumber.trim().isEmpty) {
      throw const ValidationException('Invalid phone number provided');
    }

    // In a real application, you would invoke your REST API / Firebase Auth / Twilio here
    return true;
  }

  @override
  Future<UserModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 1400));

    // Demonstrate rejection for wrong OTP (e.g. "0000" or anything that isn't 4 digits or incorrect)
    // Accept "1234" or any 4 digit except "0000" for seamless developer testing
    if (otp == '0000') {
      throw const InvalidOtpException('Invalid OTP entered. Please try using 1234.');
    }

    if (otp.length != 4) {
      throw const InvalidOtpException('OTP must be exactly 4 digits');
    }

    // Return authenticated user model
    return UserModel(
      id: 'driver_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: phoneNumber,
      name: 'Driver Partner',
      token: 'jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<bool> resendOtp({required String phoneNumber}) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return true;
  }
}
