import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ravan/features/settings/presentation/settings_screen.dart';

import '../../support/pump_app.dart';

void main() {
  testWidgets('shows theme options when dark mode toggle flag is enabled', (
    tester,
  ) async {
    dotenv.testLoad(fileInput: 'FEATURE_DARK_MODE_TOGGLE=true\n');

    await tester.pumpApp(const SettingsScreen());

    expect(find.text('System'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
  });

  testWidgets('hides theme options when dark mode toggle flag is disabled', (
    tester,
  ) async {
    dotenv.testLoad(fileInput: 'FEATURE_DARK_MODE_TOGGLE=false\n');

    await tester.pumpApp(const SettingsScreen());

    expect(find.text('System'), findsNothing);
  });
}
