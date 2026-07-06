import 'models.dart';
import 'path_utils.dart';

void printDiffPreview(RenamePlan plan) {
  if (plan.isEmpty) {
    print('No changes needed - project already matches the requested rename.');
    return;
  }

  print('The following changes will be made:\n');

  for (final change in plan.changes) {
    print('~ ${change.description}');
    _printLineDiff(change.oldContent, change.newContent);
    print('');
  }

  for (final relocation in plan.relocations) {
    print('~ ${relocation.description}');
    if (!samePath(relocation.oldFile.path, relocation.newFile.path)) {
      print('  MOVE ${relocation.oldFile.path}');
      print('    -> ${relocation.newFile.path}');
    }
    _printLineDiff(relocation.oldContent, relocation.newContent);
    print('');
  }
}

void _printLineDiff(String oldContent, String newContent) {
  final oldLines = oldContent.split('\n');
  final newLines = newContent.split('\n');
  final maxLen = oldLines.length > newLines.length
      ? oldLines.length
      : newLines.length;

  for (var i = 0; i < maxLen; i++) {
    final oldLine = i < oldLines.length ? oldLines[i] : null;
    final newLine = i < newLines.length ? newLines[i] : null;
    if (oldLine == newLine) continue;
    if (oldLine != null) print('  - $oldLine');
    if (newLine != null) print('  + $newLine');
  }
}
