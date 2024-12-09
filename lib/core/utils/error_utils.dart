import 'package:dio/dio.dart';

AppException handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutException();

    case DioExceptionType.badResponse:
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
            return NetworkException(
                e.response?.data['message'] ?? 'Bad request');
          case 401:
            return const UnauthorizedException();
          case 403:
            return const UnauthorizedException();
          case 404:
            return NetworkException(
                e.response?.data['message'] ?? 'Resource not found');
          case 422:
            return NetworkException(
                e.response?.data['message'] ?? 'Validation error');
          case 500:
          case 502:
            return const ServerException();
          default:
            return NetworkException(
                e.response?.data['message'] ?? 'Network error');
        }
      }
      return const NetworkException('Network error occurred');

    case DioExceptionType.cancel:
      return const NetworkException('Request cancelled');

    case DioExceptionType.connectionError:
      return const NoInternetException();

    default:
      return const NetworkException('Something went wrong');
  }
}

abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class NoInternetException extends AppException {
  const NoInternetException() : super('No internet connection');
}

class ServerException extends AppException {
  const ServerException([String? message]) : super(message ?? 'Server error');
}

class TimeoutException extends AppException {
  const TimeoutException() : super('Request timed out');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super('Unauthorized access');
}
