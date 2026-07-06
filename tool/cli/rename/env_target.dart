import 'dart:io';

import 'models.dart';

const _envFiles = ['.env.example', '.env.dev', '.env.staging', '.env.prod'];

/// Upserts `APP_TEXT_DIRECTION` in every env file that exists locally.
/// `.env.dev`/`.env.staging`/`.env.prod` are gitignored, so a fresh clone may
/// only have `.env.example` present -- that's fine, missing files are skipped.
List<RenameChange> planEnvTextDirectionChanges(
  Directory root,
  RenameConfig config,
) {
  final changes = <RenameChange>[];
  final keyPattern = RegExp(r'^APP_TEXT_DIRECTION=.*$', multiLine: true);

  for (final name in _envFiles) {
    final file = File('${root.path}/$name');
    if (!file.existsSync()) continue;

    final content = file.readAsStringSync();
    final newLine = 'APP_TEXT_DIRECTION=${config.textDirection}';

    final updated = keyPattern.hasMatch(content)
        ? content.replaceFirstMapped(keyPattern, (m) => newLine)
        : '${content.endsWith('\n') ? content : '$content\n'}$newLine\n';

    if (updated == content) continue;
    changes.add(
      RenameChange(
        file: file,
        description: '$name (APP_TEXT_DIRECTION)',
        oldContent: content,
        newContent: updated,
      ),
    );
  }

  return changes;
}
