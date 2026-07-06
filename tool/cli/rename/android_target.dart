import 'dart:io';

import 'models.dart';
import 'path_utils.dart';

File _gradleFile(Directory root) {
  final kts = File('${root.path}/android/app/build.gradle.kts');
  if (kts.existsSync()) return kts;
  return File('${root.path}/android/app/build.gradle');
}

String currentAndroidApplicationId(Directory root) {
  final file = _gradleFile(root);
  final content = file.readAsStringSync();
  final match = RegExp(r'applicationId\s*=?\s*"([^"]+)"').firstMatch(content);
  if (match == null) {
    throw StateError('Could not find applicationId in ${file.path}');
  }
  return match.group(1)!;
}

List<RenameChange> planAndroidGradleChanges(
  Directory root,
  RenameConfig config,
) {
  final file = _gradleFile(root);
  final content = file.readAsStringSync();
  final oldAppId = currentAndroidApplicationId(root);

  final updated = content.replaceAll('"$oldAppId"', '"${config.bundleId}"');

  if (updated == content) return [];
  return [
    RenameChange(
      file: file,
      description: '${file.uri.pathSegments.last} (applicationId, namespace)',
      oldContent: content,
      newContent: updated,
    ),
  ];
}

List<RenameChange> planAndroidManifestChanges(
  Directory root,
  RenameConfig config,
) {
  final file = File('${root.path}/android/app/src/main/AndroidManifest.xml');
  final content = file.readAsStringSync();

  final updated = content.replaceAllMapped(
    RegExp(r'android:label="[^"]*"'),
    (m) => 'android:label="${config.displayName}"',
  );

  if (updated == content) return [];
  return [
    RenameChange(
      file: file,
      description: 'AndroidManifest.xml (android:label)',
      oldContent: content,
      newContent: updated,
    ),
  ];
}

File _findMainActivityFile(Directory root) {
  for (final lang in ['kotlin', 'java']) {
    final base = Directory('${root.path}/android/app/src/main/$lang');
    if (!base.existsSync()) continue;
    for (final entity in base.listSync(recursive: true)) {
      if (entity is File &&
          (entity.path.endsWith('MainActivity.kt') ||
              entity.path.endsWith('MainActivity.java'))) {
        return entity;
      }
    }
  }
  throw StateError('Could not find MainActivity under android/app/src/main');
}

List<FileRelocation> planMainActivityRelocation(
  Directory root,
  RenameConfig config,
) {
  final oldFile = _findMainActivityFile(root);
  final content = oldFile.readAsStringSync();
  final lang = oldFile.path.endsWith('.kt') ? 'kotlin' : 'java';
  final newPackagePath = config.bundleId
      .split('.')
      .join(Platform.pathSeparator);
  final fileName = oldFile.uri.pathSegments.last;
  final newFile = File(
    '${root.path}/android/app/src/main/$lang/$newPackagePath/$fileName',
  );

  final updatedContent = content.replaceFirstMapped(
    RegExp(r'^package\s+[\w.]+', multiLine: true),
    (m) => 'package ${config.bundleId}',
  );

  if (updatedContent == content && samePath(oldFile.path, newFile.path))
    return [];

  return [
    FileRelocation(
      description: '$fileName (package declaration + directory location)',
      oldFile: oldFile,
      newFile: newFile,
      oldContent: content,
      newContent: updatedContent,
    ),
  ];
}
