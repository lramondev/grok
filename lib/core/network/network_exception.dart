import 'package:grok/core/navigation/navigation_service.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errorDetails;
  final NavigationService navigationService = NavigationService();

  NetworkException({
    required this.message,
    this.statusCode,
    this.errorDetails,
  });

  @override
  String toString() => message;
}

class ConnectionException extends NetworkException {
  ConnectionException({
    required super.message,
    super.statusCode,
    super.errorDetails,
  });
}

class TimeoutException extends NetworkException {
  TimeoutException({
    required super.message,
    super.statusCode,
    super.errorDetails,
  });
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException({
    required super.message,
    super.statusCode,
    super.errorDetails,
  }) {
    if(statusCode == 401) {
      navigationService.pushNamedAndRemoveUntil('/login');
    }
  }
}

class ForbiddenException extends NetworkException {
  ForbiddenException({
    required super.message,
    super.statusCode,
    super.errorDetails,
  });
}

class ServerException extends NetworkException {
  ServerException({
    required super.message,
    super.statusCode,
    super.errorDetails,
  });
}

class BadRequestException extends NetworkException {
  BadRequestException({
    required super.message,
    super.statusCode,
    super.errorDetails,
  });
}