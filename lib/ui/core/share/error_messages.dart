import 'package:efood/utils/app_exception.dart';

final class ErrorMessages._() {
  static String of(AppException error) => switch (error) {
    NetworkException() => 'error_network',
    ValidationException() => 'error_validation',
    UnauthorizedException() => 'error_unauthorized',
    InvalidCredentialsException() => 'error_invalid_credentials',
    ForbiddenException() => 'error_forbidden',
    NotFoundException() => 'error_not_found',
    InvalidOtpException() => 'error_invalid_otp',
    ServerException() => 'error_server',
    EmailAlreadyInUseException() => 'error_email_already_in_use',
    EmailOrPhoneAlreadyInUseException() => 'error_email_or_phone_already_in_use',
    StorageException() => 'error_storage',
    UnknownException() => 'error_unknown',
  };
}
