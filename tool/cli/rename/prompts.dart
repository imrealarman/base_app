import 'dart:io';

import 'models.dart';
import 'validators.dart';

String _ask(
  String prompt, {
  String? defaultValue,
  String? Function(String)? validate,
}) {
  while (true) {
    stdout.write(
      defaultValue != null ? '$prompt [$defaultValue]: ' : '$prompt: ',
    );
    final input = stdin.readLineSync()?.trim() ?? '';
    final value = input.isEmpty && defaultValue != null ? defaultValue : input;
    final error = validate?.call(value);
    if (error != null) {
      stdout.writeln('  x $error');
      continue;
    }
    return value;
  }
}

bool confirm(String prompt) {
  stdout.write('$prompt ');
  final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';
  return input == 'y' || input == 'yes';
}

RenameConfig promptForRenameConfig({
  required String currentPackageName,
  required String currentBundleId,
}) {
  stdout
    ..writeln('=== Flutter App Rename & Configuration ===')
    ..writeln('Current package name : $currentPackageName')
    ..writeln('Current bundle id    : $currentBundleId')
    ..writeln();

  final displayName = _ask(
    'New app display name',
    validate: validateDisplayName,
  );
  final bundleId = _ask(
    'New package/bundle id (e.g. com.company.appname)',
    validate: validateBundleId,
  );
  final description = _ask(
    'New app description',
    defaultValue: 'A Flutter application.',
  );
  final textDirection = _ask(
    'Text direction (ltr/rtl)',
    defaultValue: 'ltr',
    validate: validateTextDirection,
  ).toLowerCase();

  return RenameConfig(
    displayName: displayName,
    bundleId: bundleId,
    description: description,
    textDirection: textDirection,
  );
}
