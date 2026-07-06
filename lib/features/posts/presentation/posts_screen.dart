import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

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
              Text(t.posts.error),
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
}
