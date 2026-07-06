import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';

part 'api_client.g.dart';

/// The shared HTTP client for the whole app. Every feature's data layer
/// should depend on [apiClientProvider] rather than constructing its own
/// [Dio] instance, so base URL, timeouts, and interceptors stay centralized.
@riverpod
Dio apiClient(Ref ref) {
  final config = ref.watch(appConfigProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: false));

  ref.onDispose(dio.close);
  return dio;
}
