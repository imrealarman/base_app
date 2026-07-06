// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The shared HTTP client for the whole app. Every feature's data layer
/// should depend on [apiClientProvider] rather than constructing its own
/// [Dio] instance, so base URL, timeouts, and interceptors stay centralized.

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

/// The shared HTTP client for the whole app. Every feature's data layer
/// should depend on [apiClientProvider] rather than constructing its own
/// [Dio] instance, so base URL, timeouts, and interceptors stay centralized.

final class ApiClientProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The shared HTTP client for the whole app. Every feature's data layer
  /// should depend on [apiClientProvider] rather than constructing its own
  /// [Dio] instance, so base URL, timeouts, and interceptors stay centralized.
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$apiClientHash() => r'535905a16891c199a05249ffa6ac30efc8cdf28b';
