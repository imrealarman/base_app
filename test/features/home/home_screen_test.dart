import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ravan/features/home/presentation/home_screen.dart';

import '../../support/pump_app.dart';

void main() {
  setUp(() {
    dotenv.testLoad(
      fileInput: '''
APP_ENV=test
API_BASE_URL=https://api.test.example.com
FEATURE_ANALYTICS_ENABLED=true
''',
    );
  });

  testWidgets('shows environment and analytics text', (tester) async {
    await tester.pumpApp(const HomeScreen());

    expect(find.text('Environment: test'), findsOneWidget);
    expect(find.text('Analytics: on'), findsOneWidget);
    expect(find.text('Open settings'), findsOneWidget);
  });
}
