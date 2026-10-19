import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state: Phone input enabled, OTP section hidden
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Sending OTP to phone number: Show loading indicator on "Send OTP" button
class AuthSendingOtp extends AuthState {
  final String phoneNumber;

  const AuthSendingOtp({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// OTP Sent: Bottom section animates in displaying 4-digit OTP box & resend timer
class AuthOtpSent extends AuthState {
  final String phoneNumber;
  final String message;
  final String currentOtp;
  final bool isResending;

  const AuthOtpSent({
    required this.phoneNumber,
    this.message = 'A 4-digit code has been sent to your mobile number.',
    this.currentOtp = '',
    this.isResending = false,
  });

  AuthOtpSent copyWith({
    String? phoneNumber,
    String? message,
    String? currentOtp,
    bool? isResending,
  }) {
    return AuthOtpSent(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      message: message ?? this.message,
      currentOtp: currentOtp ?? this.currentOtp,
      isResending: isResending ?? this.isResending,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, message, currentOtp, isResending];
}

/// Verifying 4-digit OTP: Show loading indicator on "Verify" button
class AuthVerifyingOtp extends AuthState {
  final String phoneNumber;
  final String otp;

  const AuthVerifyingOtp({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object?> get props => [phoneNumber, otp];
}

/// Verification successful: Authenticated user
class AuthSuccess extends AuthState {
  final UserEntity user;
  final String message;

  const AuthSuccess({
    required this.user,
    this.message = 'Authentication successful! Welcome.',
  });

  @override
  List<Object?> get props => [user, message];
}

/// Error state: Handles both phone send error and OTP verification error
class AuthError extends AuthState {
  final String message;
  final bool isOtpStep;
  final String? phoneNumber;

  const AuthError({
    required this.message,
    required this.isOtpStep,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [message, isOtpStep, phoneNumber];
}
