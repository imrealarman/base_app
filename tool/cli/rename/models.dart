import 'dart:io';

class RenameConfig {
  const RenameConfig({
    required this.displayName,
    required this.bundleId,
    required this.description,
    required this.textDirection,
  });

  final String displayName;
  final String bundleId;
  final String description;

  /// Either `'ltr'` or `'rtl'`, written to `APP_TEXT_DIRECTION` in the env files.
  final String textDirection;

  String get packageName => bundleId.split('.').last;
}

/// An in-place content edit to an existing file.
class RenameChange {
  const RenameChange({
    required this.file,
    required this.description,
    required this.oldContent,
    required this.newContent,
  });

  final File file;
  final String description;
  final String oldContent;
  final String newContent;
}

/// A file whose content changes AND which physically moves to a new path
/// (used for MainActivity, whose directory encodes the Android package).
class FileRelocation {
  const FileRelocation({
    required this.description,
    required this.oldFile,
    required this.newFile,
    required this.oldContent,
    required this.newContent,
  });

  final String description;
  final File oldFile;
  final File newFile;
  final String oldContent;
  final String newContent;
}

class RenamePlan {
  const RenamePlan({required this.changes, required this.relocations});

  final List<RenameChange> changes;
  final List<FileRelocation> relocations;

  bool get isEmpty => changes.isEmpty && relocations.isEmpty;
}
