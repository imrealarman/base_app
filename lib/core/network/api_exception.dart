import 'package:dio/dio.dart';

/// A typed, feature-agnostic classification of what went wrong on an API
/// call, so a screen can show a specific message instead of dio's raw
/// exception text. Catch [DioException] at the data-layer boundary and
/// rethrow `ApiException.fromDio(error)` — see `lib/features/posts/data/posts_api.dart`
/// for the worked example.
enum ApiExceptionType { network, timeout, notFound, server, unknown }

class ApiException implements Exception {
  const ApiException(this.type, {this.statusCode});

  factory ApiException.fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return const ApiException(ApiExceptionType.network);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiException(ApiExceptionType.timeout);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return ApiException(
          statusCode == 404
              ? ApiExceptionType.notFound
              : ApiExceptionType.server,
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const ApiException(ApiExceptionType.unknown);
    }
  }

  final ApiExceptionType type;
  final int? statusCode;

  @override
  String toString() => 'ApiException(type: $type, statusCode: $statusCode)';
}
