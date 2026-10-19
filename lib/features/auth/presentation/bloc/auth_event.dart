import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched when user enters phone number and taps "Send OTP"
class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Dispatched when user enters 4-digit OTP and taps "Verify & Proceed"
class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const VerifyOtpEvent({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object?> get props => [phoneNumber, otp];
}

/// Dispatched when user clicks "Resend OTP"
class ResendOtpEvent extends AuthEvent {
  final String phoneNumber;

  const ResendOtpEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Dispatched when user taps "Edit Number" to go back to phone input
class ResetToPhoneInputEvent extends AuthEvent {
  const ResetToPhoneInputEvent();
}

/// Dispatched on OTP change to enable/disable button or trigger auto-verify
class OtpChangedEvent extends AuthEvent {
  final String otp;

  const OtpChangedEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}
