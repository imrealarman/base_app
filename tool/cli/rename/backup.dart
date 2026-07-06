import 'dart:io';

import 'models.dart';
import 'path_utils.dart';

Directory createBackup(Directory root, RenamePlan plan) {
  final timestamp = DateTime.now().toIso8601String().replaceAll(
    RegExp('[:.]'),
    '-',
  );
  final backupDir = Directory('${root.path}/.rename_backup/$timestamp');
  backupDir.createSync(recursive: true);

  void backupFile(File file) {
    if (!file.existsSync()) return;
    final relative = file.path.substring(root.path.length + 1);
    final dest = File('${backupDir.path}/$relative');
    dest.parent.createSync(recursive: true);
    file.copySync(dest.path);
  }

  for (final change in plan.changes) {
    backupFile(change.file);
  }
  for (final relocation in plan.relocations) {
    backupFile(relocation.oldFile);
  }

  return backupDir;
}

void restoreBackup(
  Directory root,
  Directory backupDir,
  RenamePlan plan, {
  required Set<Directory> createdDirs,
}) {
  File backupFileFor(File original) {
    final relative = original.path.substring(root.path.length + 1);
    return File('${backupDir.path}/$relative');
  }

  for (final change in plan.changes) {
    final backup = backupFileFor(change.file);
    if (backup.existsSync()) {
      change.file.writeAsStringSync(backup.readAsStringSync());
    }
  }

  for (final relocation in plan.relocations) {
    if (!samePath(relocation.newFile.path, relocation.oldFile.path) &&
        relocation.newFile.existsSync()) {
      relocation.newFile.deleteSync();
    }
    final backup = backupFileFor(relocation.oldFile);
    if (backup.existsSync()) {
      relocation.oldFile.parent.createSync(recursive: true);
      relocation.oldFile.writeAsStringSync(backup.readAsStringSync());
    }
  }

  for (final dir in createdDirs) {
    var current = dir;
    while (current.existsSync() && current.listSync().isEmpty) {
      final parent = current.parent;
      current.deleteSync();
      current = parent;
    }
  }
}
