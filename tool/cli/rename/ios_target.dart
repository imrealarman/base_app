import 'dart:io';

import 'models.dart';

String currentIosBundleId(Directory root) {
  final file = File('${root.path}/ios/Runner.xcodeproj/project.pbxproj');
  final content = file.readAsStringSync();
  final matches = RegExp(
    r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*([^;]+);',
  ).allMatches(content);
  for (final m in matches) {
    final value = m.group(1)!.trim();
    if (!value.endsWith('.RunnerTests')) return value;
  }
  throw StateError('Could not find PRODUCT_BUNDLE_IDENTIFIER in ${file.path}');
}

List<RenameChange> planIosProjectChanges(Directory root, RenameConfig config) {
  final file = File('${root.path}/ios/Runner.xcodeproj/project.pbxproj');
  final content = file.readAsStringSync();
  final oldBundleId = currentIosBundleId(root);

  var updated = content.replaceAll(
    'PRODUCT_BUNDLE_IDENTIFIER = $oldBundleId.RunnerTests;',
    'PRODUCT_BUNDLE_IDENTIFIER = ${config.bundleId}.RunnerTests;',
  );
  updated = updated.replaceAll(
    'PRODUCT_BUNDLE_IDENTIFIER = $oldBundleId;',
    'PRODUCT_BUNDLE_IDENTIFIER = ${config.bundleId};',
  );

  if (updated == content) return [];
  return [
    RenameChange(
      file: file,
      description: 'project.pbxproj (PRODUCT_BUNDLE_IDENTIFIER)',
      oldContent: content,
      newContent: updated,
    ),
  ];
}

List<RenameChange> planIosInfoPlistChanges(
  Directory root,
  RenameConfig config,
) {
  final file = File('${root.path}/ios/Runner/Info.plist');
  final content = file.readAsStringSync();

  var updated = content.replaceFirstMapped(
    RegExp(r'(<key>CFBundleDisplayName</key>\s*<string>)([^<]*)(</string>)'),
    (m) => '${m.group(1)}${config.displayName}${m.group(3)}',
  );
  updated = updated.replaceFirstMapped(
    RegExp(r'(<key>CFBundleName</key>\s*<string>)([^<]*)(</string>)'),
    (m) => '${m.group(1)}${config.packageName}${m.group(3)}',
  );

  if (updated == content) return [];
  return [
    RenameChange(
      file: file,
      description: 'Info.plist (CFBundleDisplayName, CFBundleName)',
      oldContent: content,
      newContent: updated,
    ),
  ];
}
