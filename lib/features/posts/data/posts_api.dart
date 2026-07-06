import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import 'post.dart';

part 'posts_api.g.dart';

/// Fetches posts from the API configured via `API_BASE_URL`. This is the
/// template's worked example of a per-feature data source: one Dio call,
/// wrapped in a Riverpod [FutureProvider] so screens get loading/error/data
/// states via [AsyncValue] for free (`ref.watch(postsProvider)`), with
/// automatic caching and re-fetch-on-invalidate (`ref.invalidate(postsProvider)`).
@riverpod
Future<List<Post>> posts(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  final response = await client.get<List<dynamic>>('/posts');
  final data = response.data ?? [];
  return data
      .map((json) => Post.fromJson(json as Map<String, dynamic>))
      .toList();
}
