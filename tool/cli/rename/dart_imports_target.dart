import 'dart:io';

import 'models.dart';

List<RenameChange> planDartImportChanges(
  Directory root, {
  required String oldPackageName,
  required String newPackageName,
}) {
  if (oldPackageName == newPackageName) return [];

  final oldToken = 'package:$oldPackageName/';
  final newToken = 'package:$newPackageName/';
  final changes = <RenameChange>[];

  for (final dirName in ['lib', 'test', 'integration_test']) {
    final dir = Directory('${root.path}/$dirName');
    if (!dir.existsSync()) continue;

    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final content = entity.readAsStringSync();
      if (!content.contains(oldToken)) continue;

      final updated = content.replaceAll(oldToken, newToken);
      final relative = entity.path.substring(root.path.length + 1);
      changes.add(
        RenameChange(
          file: entity,
          description: 'Dart import ($relative)',
          oldContent: content,
          newContent: updated,
        ),
      );
    }
  }

  return changes;
}
