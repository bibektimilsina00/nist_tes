import 'package:dio/dio.dart';

/// Extracts a user-friendly error message from various types of exceptions.
///
/// - For DioException, tries to extract detailed error message from the response.
/// - For custom exceptions, can directly access known properties.
/// - Removes class name prefixes from standard exceptions.
String getErrorMessage(dynamic exception) {
  // Handle DioException for network-related errors with detailed backend responses
  if (exception is DioException) {
    // Check if there's a response and try to extract the error message
    if (exception.response != null && exception.response!.data is Map) {
      final response = exception.response!.data;
      // Example for a common error format; adjust based on your API's error structure
      if (response.containsKey('detail')) {
        // If 'detail' is a list, we concatenate all messages (common in validation errors)
        if (response['detail'] is List) {
          return response['detail'].map((e) => e['msg']).join(', ');
        }
        // If 'detail' is a simple string, return it directly
        return response['detail'];
      }
    }
    // If no detailed error message is available, fallback to DioException's message
    return exception.message ?? "An unexpected error occurred.";
  }
  // Handle custom exceptions if you have any; adjust 'MyCustomException' as needed
  else if (exception is MyCustomException) {
    return exception.message;
  }
  // Handle standard exceptions by removing the exception class name prefix
  else if (exception is Exception) {
    return exception.toString().replaceFirst(RegExp(r'Exception: '), '');
  }
  // Fallback for any other types of errors or messages
  return exception.toString();
}

void handleDioException(DioException e, {String? route}) {
  String errorMessage = 'An unexpected error occurred';

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      errorMessage = 'Connection timed out';
      break;
    case DioExceptionType.sendTimeout:
      errorMessage = 'Send timeout';
      break;
    case DioExceptionType.receiveTimeout:
      errorMessage = 'Receive timeout';
      break;
    case DioExceptionType.badResponse:
      // Handle different status codes within response errors
      if (e.response != null) {
        try {
          if (e.response?.statusCode == 400) {
            errorMessage = e.response!.data['detail'];
            break;
          } else if (e.response?.statusCode == 401) {
            errorMessage = 'Unauthorized';
            break;
          } else if (e.response?.statusCode == 422) {
            errorMessage = e.response!.data['detail'][0]['msg'].toString();
            break;
          } else if (e.response?.statusCode == 404) {
            errorMessage = 'Resource not found';
            break;
          } else if (e.response?.statusCode == 500) {
            errorMessage = 'Internal server error';
            break;
          } else {
            errorMessage =
                'Received an error response with status code: ${e.response?.statusCode}';
          }
        } catch (_) {
          errorMessage = 'Failed to parse error message from response';
        }
      } else {
        errorMessage = 'Received an empty response';
      }
      break;
    case DioExceptionType.cancel:
      errorMessage = 'Request was cancelled';
      break;
    case DioExceptionType.unknown:
      errorMessage = e.message?[0].toUpperCase() ?? 'An unknown error occurred';
      break;
    default:
      errorMessage = 'An unexpected error occurred';
  }

  // Always throw an exception with a clear message
  throw Exception(errorMessage);
}

/// Example custom exception class; define your own as needed
class MyCustomException implements Exception {
  final String message;

  MyCustomException(this.message);

  @override
  String toString() => message;
}