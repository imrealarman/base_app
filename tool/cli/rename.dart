import 'dart:io';

import 'rename/android_target.dart' as android_target;
import 'rename/apply.dart';
import 'rename/backup.dart';
import 'rename/build_plan.dart';
import 'rename/diff.dart';
import 'rename/models.dart';
import 'rename/path_utils.dart';
import 'rename/prompts.dart';
import 'rename/pubspec_target.dart' as pubspec_target;

Future<void> main() async {
  final root = Directory.current;

  final currentPackageName = pubspec_target.currentPackageName(root);
  String currentBundleId;
  try {
    currentBundleId = android_target.currentAndroidApplicationId(root);
  } catch (_) {
    currentBundleId = 'com.example.$currentPackageName';
  }

  final RenameConfig config = promptForRenameConfig(
    currentPackageName: currentPackageName,
    currentBundleId: currentBundleId,
  );

  final plan = buildRenamePlan(root, config);
  print('');
  printDiffPreview(plan);

  if (plan.isEmpty) {
    return;
  }

  print('');
  if (!confirm('Apply these changes? [y/N]')) {
    print('Aborted. No files were changed.');
    return;
  }

  final backupDir = createBackup(root, plan);
  try {
    applyPlan(plan);
    print('');
    print('Rename applied successfully. ');
    print('Backup kept at: ${backupDir.path}');
    print(
      'Next steps: run "flutter pub get" then "flutter analyze" to confirm everything still builds.',
    );
  } catch (e) {
    stderr.writeln('');
    stderr.writeln('Rename failed: $e');
    stderr.writeln('Rolling back all changes...');
    final createdDirs = <Directory>{
      for (final relocation in plan.relocations)
        if (!samePath(relocation.newFile.path, relocation.oldFile.path))
          relocation.newFile.parent,
    };
    try {
      restoreBackup(root, backupDir, plan, createdDirs: createdDirs);
      stderr.writeln(
        'Rollback complete. Project restored to its previous state.',
      );
    } catch (rollbackError) {
      stderr.writeln('Rollback itself failed: $rollbackError');
      stderr.writeln('Restore manually from the backup at: ${backupDir.path}');
    }
    exitCode = 1;
  }
}
