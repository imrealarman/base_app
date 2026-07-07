import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ravan/core/network/api_client.dart';
import 'package:ravan/features/posts/presentation/posts_screen.dart';

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

  testWidgets('shows a network-specific message when offline', (tester) async {
    when(() => dio.get<List<dynamic>>('/posts')).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/posts'),
        type: DioExceptionType.connectionError,
      ),
    );

    await tester.pumpApp(
      const PostsScreen(),
      overrides: [apiClientProvider.overrideWithValue(dio)],
    );
    await tester.pumpAndSettle();

    expect(
      find.text('No internet connection. Check your network and try again.'),
      findsOneWidget,
    );
  });

  testWidgets('shows a not-found-specific message on a 404', (tester) async {
    when(() => dio.get<List<dynamic>>('/posts')).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/posts'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/posts'),
          statusCode: 404,
        ),
      ),
    );

    await tester.pumpApp(
      const PostsScreen(),
      overrides: [apiClientProvider.overrideWithValue(dio)],
    );
    await tester.pumpAndSettle();

    expect(find.text("Posts couldn't be found."), findsOneWidget);
  });
}
