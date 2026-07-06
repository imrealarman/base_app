import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:base_app/core/network/api_client.dart';
import 'package:base_app/features/posts/presentation/posts_screen.dart';

import '../../support/pump_app.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;

  setUp(() {
    dio = _MockDio();
  });

  testWidgets('shows posts once loaded', (tester) async {
    when(() => dio.get<List<dynamic>>('/posts')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/posts'),
        data: [
          {'id': 1, 'title': 'First post', 'body': 'Hello world'},
        ],
      ),
    );

    await tester.pumpApp(
      const PostsScreen(),
      overrides: [apiClientProvider.overrideWithValue(dio)],
    );
    await tester.pumpAndSettle();

    expect(find.text('First post'), findsOneWidget);
    expect(find.text('Hello world'), findsOneWidget);
  });

  testWidgets('shows error and retries on failure', (tester) async {
    when(
      () => dio.get<List<dynamic>>('/posts'),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: '/posts')));

    await tester.pumpApp(
      const PostsScreen(),
      overrides: [apiClientProvider.overrideWithValue(dio)],
    );
    await tester.pumpAndSettle();

    expect(find.text('Something went wrong loading posts.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
