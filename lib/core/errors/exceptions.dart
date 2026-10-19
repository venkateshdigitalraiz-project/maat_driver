class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);

  @override
  String toString() => message;
}

class InvalidOtpException implements Exception {
  final String message;
  const InvalidOtpException([this.message = 'Invalid 4-digit OTP entered']);

  @override
  String toString() => message;
}
