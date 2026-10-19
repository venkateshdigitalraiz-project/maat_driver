class PhoneValidator {
  /// Validates standard 10-digit phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    final cleaned = value.replaceAll(RegExp(r'\D'), '');

    if (cleaned.length < 10) {
      return 'Please enter a valid 10-digit mobile number';
    }

    if (cleaned.length > 10) {
      return 'Mobile number should not exceed 10 digits';
    }

    // Usually starts with 6, 7, 8, or 9 for Indian numbers or standard mobile digits
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleaned)) {
      return 'Please enter a valid mobile number';
    }

    return null;
  }

  /// Validates a 4-digit OTP
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the 4-digit OTP';
    }

    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length != 4) {
      return 'OTP must be exactly 4 digits';
    }

    return null;
  }
}
