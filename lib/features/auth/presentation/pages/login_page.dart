import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/phone_validator.dart';
import '../../../dashboard/presentation/pages/driver_dashboard_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/countdown_timer_widget.dart';
import '../widgets/otp_digit_input.dart';
import '../widgets/phone_input_field.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<OtpDigitInputState> _otpKey = GlobalKey<OtpDigitInputState>();

  String? _phoneError;
  String _enteredOtp = '';
  String? _otpError;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSendOtpPressed() {
    FocusScope.of(context).unfocus();
    final validation = PhoneValidator.validatePhoneNumber(_phoneController.text);
    if (validation != null) {
      setState(() {
        _phoneError = validation;
      });
      return;
    }

    setState(() {
      _phoneError = null;
    });

    context.read<AuthBloc>().add(
          SendOtpEvent(phoneNumber: _phoneController.text.trim()),
        );
  }

  void _onVerifyOtpPressed() {
    FocusScope.of(context).unfocus();
    final validation = PhoneValidator.validateOtp(_enteredOtp);
    if (validation != null) {
      setState(() {
        _otpError = validation;
      });
      return;
    }

    setState(() {
      _otpError = null;
    });

    context.read<AuthBloc>().add(
          VerifyOtpEvent(
            phoneNumber: _phoneController.text.trim(),
            otp: _enteredOtp,
          ),
        );
  }

  void _onResendOtp() {
    _otpKey.currentState?.clear();
    setState(() {
      _enteredOtp = '';
      _otpError = null;
    });
    context.read<AuthBloc>().add(
          ResendOtpEvent(phoneNumber: _phoneController.text.trim()),
        );
  }

  void _onEditPhoneNumber() {
    _animationController.reverse().then((_) {
      _otpKey.currentState?.clear();
      setState(() {
        _enteredOtp = '';
        _otpError = null;
      });
      context.read<AuthBloc>().add(const ResetToPhoneInputEvent());
    });
  }

  void _showSuccessDialog(BuildContext context, AuthSuccess state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.successLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 42,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Login Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back, ${state.user.name}!\nMobile: +91 ${state.user.phoneNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Go to Dashboard',
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const DriverDashboardPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthOtpSent) {
              _animationController.forward();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                ),
              );
            } else if (state is AuthError) {
              if (state.isOtpStep) {
                setState(() {
                  _otpError = state.message;
                });
              } else {
                setState(() {
                  _phoneError = state.message;
                });
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(16),
                ),
              );
            } else if (state is AuthSuccess) {
              _showSuccessDialog(context, state);
            }
          },
          builder: (context, state) {
            final bool isOtpPhase = state is AuthOtpSent ||
                state is AuthVerifyingOtp ||
                (state is AuthError && state.isOtpStep);

            final bool isSendingOtp = state is AuthSendingOtp;
            final bool isVerifyingOtp = state is AuthVerifyingOtp;
            final bool isResending = (state is AuthOtpSent) && state.isResending;

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Branding
                      _buildHeader(),

                      const SizedBox(height: 32),

                      // Card Container
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border, width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.06),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Mobile Number Input Section
                            PhoneInputField(
                              controller: _phoneController,
                              isReadOnly: isOtpPhase,
                              errorText: _phoneError,
                              onChanged: (_) {
                                if (_phoneError != null) {
                                  setState(() => _phoneError = null);
                                }
                              },
                              onEditPressed: _onEditPhoneNumber,
                              onClearPressed: () {
                                _phoneController.clear();
                                setState(() => _phoneError = null);
                              },
                            ),

                            // If not in OTP phase, display "Send OTP" button
                            if (!isOtpPhase) ...[
                              const SizedBox(height: 24),
                              PrimaryButton(
                                text: 'Send OTP',
                                icon: Icons.arrow_forward_rounded,
                                isLoading: isSendingOtp,
                                onPressed: _onSendOtpPressed,
                              ),
                            ],

                            // Bottom 4-digit OTP Box Section (Animated)
                            if (isOtpPhase) ...[
                              const SizedBox(height: 24),
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: _buildOtpSection(
                                    isVerifying: isVerifyingOtp,
                                    isResending: isResending,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Demo Hint Banner
                      _buildDemoHint(),

                      const SizedBox(height: 24),

                      // Terms and Privacy Note
                      _buildTermsFooter(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App Icon / Logo Badge
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.local_taxi_rounded,
              size: 34,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Welcome to Driver Portal',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your mobile number to receive a secure one-time verification code.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpSection({
    required bool isVerifying,
    required bool isResending,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider with label
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primarySubtle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_clock_outlined,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        const SizedBox(height: 20),

        const Text(
          'Verification Code',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Enter the 4-digit code sent to +91 ${_phoneController.text.trim()}',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 18),

        // 4-Digit Box Input
        OtpDigitInput(
          key: _otpKey,
          length: 4,
          hasError: _otpError != null,
          onChanged: (otp) {
            setState(() {
              _enteredOtp = otp;
              if (_otpError != null) _otpError = null;
            });
            context.read<AuthBloc>().add(OtpChangedEvent(otp: otp));
          },
          onCompleted: (otp) {
            setState(() {
              _enteredOtp = otp;
              _otpError = null;
            });
            _onVerifyOtpPressed();
          },
        ),

        // OTP Error text
        if (_otpError != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.error_outline,
                size: 14,
                color: AppColors.error,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _otpError!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],

        const SizedBox(height: 20),

        // Countdown Timer & Resend Button
        CountdownTimerWidget(
          initialSeconds: 30,
          isResending: isResending,
          onResend: _onResendOtp,
        ),

        const SizedBox(height: 24),

        // Verify & Proceed Button
        PrimaryButton(
          text: 'Verify & Proceed',
          icon: Icons.verified_user_outlined,
          isLoading: isVerifying,
          onPressed: _enteredOtp.length == 4 ? _onVerifyOtpPressed : null,
        ),
      ],
    );
  }

  Widget _buildDemoHint() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF16A34A), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Demo Tip: Enter any 10-digit number (e.g. 9876543210) & use OTP: 1234 to verify.',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF15803D),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsFooter() {
    return const Column(
      children: [
        Text(
          'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textMuted,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
