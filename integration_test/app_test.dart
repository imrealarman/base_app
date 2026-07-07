import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ravan/app.dart';
import 'package:ravan/core/config/environment.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates from home to settings and back', (tester) async {
    dotenv.testLoad(
      fileInput: '''
APP_ENV=test
API_BASE_URL=https://api.test.example.com
FEATURE_SETTINGS_SCREEN=true
''',
    );

    await tester.pumpWidget(
      const ProviderScope(child: App(environment: Environment.dev)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Base App'), findsOneWidget);

    await tester.tap(find.text('Open settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Base App'), findsOneWidget);
  });
}
