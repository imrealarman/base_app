import 'dart:io';

import 'models.dart';

String currentPackageName(Directory root) {
  final file = File('${root.path}/pubspec.yaml');
  final content = file.readAsStringSync();
  final match = RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(content);
  if (match == null) {
    throw StateError('Could not find "name:" in ${file.path}');
  }
  return match.group(1)!;
}

List<RenameChange> planPubspecChanges(Directory root, RenameConfig config) {
  final file = File('${root.path}/pubspec.yaml');
  final content = file.readAsStringSync();
  final safeDescription = config.description.replaceAll('"', "'");

  var updated = content.replaceFirstMapped(
    RegExp(r'^name:\s*\S+', multiLine: true),
    (m) => 'name: ${config.packageName}',
  );
  updated = updated.replaceFirstMapped(
    RegExp(r'^description:\s*.*$', multiLine: true),
    (m) => 'description: "$safeDescription"',
  );

  if (updated == content) return [];
  return [
    RenameChange(
      file: file,
      description: 'pubspec.yaml (name, description)',
      oldContent: content,
      newContent: updated,
    ),
  ];
}
