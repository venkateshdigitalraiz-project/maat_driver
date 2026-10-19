import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  AuthBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
  }) : super(const AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<ResetToPhoneInputEvent>(_onResetToPhoneInput);
    on<OtpChangedEvent>(_onOtpChanged);
  }

  Future<void> _onSendOtp(
    SendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSendingOtp(phoneNumber: event.phoneNumber));

    try {
      await sendOtpUseCase(phoneNumber: event.phoneNumber);
      emit(AuthOtpSent(
        phoneNumber: event.phoneNumber,
        message: 'OTP sent to +91 ${event.phoneNumber}',
      ));
    } on Failure catch (e) {
      emit(AuthError(
        message: e.message,
        isOtpStep: false,
        phoneNumber: event.phoneNumber,
      ));
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isOtpStep: false,
        phoneNumber: event.phoneNumber,
      ));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthVerifyingOtp(
      phoneNumber: event.phoneNumber,
      otp: event.otp,
    ));

    try {
      final user = await verifyOtpUseCase(
        phoneNumber: event.phoneNumber,
        otp: event.otp,
      );
      emit(AuthSuccess(user: user));
    } on Failure catch (e) {
      emit(AuthError(
        message: e.message,
        isOtpStep: true,
        phoneNumber: event.phoneNumber,
      ));
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isOtpStep: true,
        phoneNumber: event.phoneNumber,
      ));
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthOtpSent) {
      emit((state as AuthOtpSent).copyWith(isResending: true));
    }

    try {
      await resendOtpUseCase(phoneNumber: event.phoneNumber);
      emit(AuthOtpSent(
        phoneNumber: event.phoneNumber,
        message: 'A fresh OTP has been resent to your number!',
        isResending: false,
      ));
    } on Failure catch (e) {
      emit(AuthError(
        message: e.message,
        isOtpStep: true,
        phoneNumber: event.phoneNumber,
      ));
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isOtpStep: true,
        phoneNumber: event.phoneNumber,
      ));
    }
  }

  void _onResetToPhoneInput(
    ResetToPhoneInputEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthInitial());
  }

  void _onOtpChanged(
    OtpChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthOtpSent) {
      emit((state as AuthOtpSent).copyWith(currentOtp: event.otp));
    }
  }
}
