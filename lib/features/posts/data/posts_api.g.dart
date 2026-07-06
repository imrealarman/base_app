// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches posts from the API configured via `API_BASE_URL`. This is the
/// template's worked example of a per-feature data source: one Dio call,
/// wrapped in a Riverpod [FutureProvider] so screens get loading/error/data
/// states via [AsyncValue] for free (`ref.watch(postsProvider)`), with
/// automatic caching and re-fetch-on-invalidate (`ref.invalidate(postsProvider)`).
///
/// [DioException] is caught and rethrown as [ApiException] so the screen can
/// show a message specific to what went wrong (offline, timeout, 404, ...)
/// instead of dio's raw exception text — see `posts_screen.dart`.

@ProviderFor(posts)
final postsProvider = PostsProvider._();

/// Fetches posts from the API configured via `API_BASE_URL`. This is the
/// template's worked example of a per-feature data source: one Dio call,
/// wrapped in a Riverpod [FutureProvider] so screens get loading/error/data
/// states via [AsyncValue] for free (`ref.watch(postsProvider)`), with
/// automatic caching and re-fetch-on-invalidate (`ref.invalidate(postsProvider)`).
///
/// [DioException] is caught and rethrown as [ApiException] so the screen can
/// show a message specific to what went wrong (offline, timeout, 404, ...)
/// instead of dio's raw exception text — see `posts_screen.dart`.

final class PostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Post>>,
          List<Post>,
          FutureOr<List<Post>>
        >
    with $FutureModifier<List<Post>>, $FutureProvider<List<Post>> {
  /// Fetches posts from the API configured via `API_BASE_URL`. This is the
  /// template's worked example of a per-feature data source: one Dio call,
  /// wrapped in a Riverpod [FutureProvider] so screens get loading/error/data
  /// states via [AsyncValue] for free (`ref.watch(postsProvider)`), with
  /// automatic caching and re-fetch-on-invalidate (`ref.invalidate(postsProvider)`).
  ///
  /// [DioException] is caught and rethrown as [ApiException] so the screen can
  /// show a message specific to what went wrong (offline, timeout, 404, ...)
  /// instead of dio's raw exception text — see `posts_screen.dart`.
  PostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsHash();

  @$internal
  @override
  $FutureProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Post>> create(Ref ref) {
    return posts(ref);
  }
}

String _$postsHash() => r'2206abb7363b35b63d2e3c7cca5f6760c94d2c99';
