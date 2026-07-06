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

@ProviderFor(posts)
final postsProvider = PostsProvider._();

/// Fetches posts from the API configured via `API_BASE_URL`. This is the
/// template's worked example of a per-feature data source: one Dio call,
/// wrapped in a Riverpod [FutureProvider] so screens get loading/error/data
/// states via [AsyncValue] for free (`ref.watch(postsProvider)`), with
/// automatic caching and re-fetch-on-invalidate (`ref.invalidate(postsProvider)`).

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

String _$postsHash() => r'71040065fe7e7498a4ba1ba71a7802a5e8a5cbf0';
