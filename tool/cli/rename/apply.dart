import 'dart:io';

import 'models.dart';
import 'path_utils.dart';

/// Applies [plan] in place, returning the set of directories that were newly
/// created for relocations (so a rollback can remove them again if empty).
Set<Directory> applyPlan(RenamePlan plan) {
  final createdDirs = <Directory>{};

  for (final change in plan.changes) {
    change.file.writeAsStringSync(change.newContent);
  }

  for (final relocation in plan.relocations) {
    if (samePath(relocation.newFile.path, relocation.oldFile.path)) {
      relocation.newFile.writeAsStringSync(relocation.newContent);
      continue;
    }

    if (!relocation.newFile.parent.existsSync()) {
      relocation.newFile.parent.createSync(recursive: true);
      createdDirs.add(relocation.newFile.parent);
    }
    relocation.newFile.writeAsStringSync(relocation.newContent);
    relocation.oldFile.deleteSync();
  }

  return createdDirs;
}
