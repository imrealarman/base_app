import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../core/network/api_exception.dart';
import '../../../i18n/strings.g.dart';
import '../data/posts_api.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final posts = ref.watch(postsProvider);

    return FScaffold(
      header: FHeader(title: Text(t.posts.title)),
      child: posts.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final post = items[index];
            return FCard(title: Text(post.title), subtitle: Text(post.body));
          },
        ),
        loading: () => const Center(child: FCircularProgress()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(_errorMessage(t, error)),
              FButton(
                onPress: () => ref.invalidate(postsProvider),
                child: Text(t.posts.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _errorMessage(Translations t, Object error) {
    if (error is! ApiException) return t.posts.error;
    return switch (error.type) {
      ApiExceptionType.network => t.posts.errorNetwork,
      ApiExceptionType.timeout => t.posts.errorTimeout,
      ApiExceptionType.notFound => t.posts.errorNotFound,
      ApiExceptionType.server => t.posts.errorServer,
      ApiExceptionType.unknown => t.posts.error,
    };
  }
}
