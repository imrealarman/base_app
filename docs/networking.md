# Networking & data fetching

The template uses [dio](https://pub.dev/packages/dio) for HTTP and Riverpod's `FutureProvider`
(via `riverpod_generator`) as the data-caching layer — no separate "React Query"-style package
is needed since Riverpod already covers caching, invalidation, and loading/error/data states.

## The shared client

`lib/core/network/api_client.dart` exposes a single `apiClientProvider` — a `Dio` instance
configured once with `API_BASE_URL` (from `AppConfig`, see [environments.md](environments.md)),
timeouts, and a request/response logger. Every feature's data layer should read this provider
rather than constructing its own `Dio()`, so base URL and interceptors stay centralized.

## Example: the `posts` feature

`lib/features/posts/` is a complete worked example:

- `data/post.dart` — a plain model with `fromJson`/`toJson`.
- `data/posts_api.dart` — a `@riverpod` function that calls `apiClientProvider.get('/posts')`
  and maps the response into `List<Post>`.
- `presentation/posts_screen.dart` — watches `postsProvider` (an `AsyncValue<List<Post>>`) and
  handles all three states with `.when(data:, loading:, error:)`.

```dart
@riverpod
Future<List<Post>> posts(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  final response = await client.get<List<dynamic>>('/posts');
  return (response.data ?? [])
      .map((json) => Post.fromJson(json as Map<String, dynamic>))
      .toList();
}
```

```dart
final posts = ref.watch(postsProvider);
return posts.when(
  data: (items) => /* build list */,
  loading: () => const FCircularProgress(),
  error: (error, stackTrace) => /* build retry button, e.g. ref.invalidate(postsProvider) */,
);
```

## Error handling

`lib/core/network/api_exception.dart` classifies a caught `DioException` into an
`ApiException` with a feature-agnostic `ApiExceptionType` (`network`, `timeout`, `notFound`,
`server`, `unknown`), so a screen can show a message specific to what went wrong instead of
dio's raw exception text:

```dart
try {
  final response = await client.get<List<dynamic>>('/posts');
  // ...
} on DioException catch (error) {
  throw ApiException.fromDio(error);
}
```

`posts_screen.dart`'s `error:` branch switches on `error.type` to pick the right i18n string
(`t.posts.errorNetwork`, `t.posts.errorTimeout`, etc.), falling back to a generic message for
anything that isn't an `ApiException`. Follow the same pattern for new API-backed features:
catch `DioException` in the data layer, map it to `ApiException`, and switch on `.type` in the
screen.

For uncaught errors that escape this pattern entirely (a bug, not an expected failure mode),
see [error-handling.md](error-handling.md).

## Adding a new API-backed feature

1. Add a model with `fromJson`/`toJson` under `lib/features/<name>/data/`.
2. Add a `@riverpod` function (or `@riverpod class ... extends _$...Notifier` if it needs
   mutations, not just reads) calling `ref.watch(apiClientProvider)`.
3. Run `dart run build_runner build --delete-conflicting-outputs` to generate the provider.
4. Watch it from a screen with `ref.watch(yourProvider)` and handle `AsyncValue`'s three states.
5. To refresh on demand: `ref.invalidate(yourProvider)`.
6. To test it: override `apiClientProvider` with a `mocktail`-mocked `Dio` in a `ProviderScope` —
   see `test/features/posts/posts_screen_test.dart` for the full pattern, and
   [testing.md](testing.md) for the `pumpApp` helper it uses.
