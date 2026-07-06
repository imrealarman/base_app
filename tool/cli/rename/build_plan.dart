import 'dart:io';

import 'android_target.dart' as android_target;
import 'dart_imports_target.dart' as dart_imports_target;
import 'env_target.dart' as env_target;
import 'ios_target.dart' as ios_target;
import 'models.dart';
import 'pubspec_target.dart' as pubspec_target;

RenamePlan buildRenamePlan(Directory root, RenameConfig config) {
  final oldPackageName = pubspec_target.currentPackageName(root);

  final changes = <RenameChange>[
    ...pubspec_target.planPubspecChanges(root, config),
    ...android_target.planAndroidGradleChanges(root, config),
    ...android_target.planAndroidManifestChanges(root, config),
    ...ios_target.planIosProjectChanges(root, config),
    ...ios_target.planIosInfoPlistChanges(root, config),
    ...dart_imports_target.planDartImportChanges(
      root,
      oldPackageName: oldPackageName,
      newPackageName: config.packageName,
    ),
    ...env_target.planEnvTextDirectionChanges(root, config),
  ];

  final relocations = <FileRelocation>[
    ...android_target.planMainActivityRelocation(root, config),
  ];

  return RenamePlan(changes: changes, relocations: relocations);
}
