import 'dart:io';

/// Enforces Conventional Commits (https://www.conventionalcommits.org):
/// `type(scope?): subject`. Invoked by lefthook's `commit-msg` hook with the
/// path to the file containing the candidate commit message as argv[0].
const _validTypes = {
  'build',
  'chore',
  'ci',
  'docs',
  'feat',
  'fix',
  'perf',
  'refactor',
  'revert',
  'style',
  'test',
};

final _pattern = RegExp(r'^(\w+)(\([\w\-./]+\))?!?: .+');

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln(
      'check_commit_msg: expected the commit message file path as argv[0].',
    );
    exitCode = 1;
    return;
  }

  final message = File(args[0]).readAsStringSync().trim();
  final firstLine = message.split('\n').first;

  final match = _pattern.firstMatch(firstLine);
  if (match == null || !_validTypes.contains(match.group(1))) {
    stderr
      ..writeln('Commit message does not follow Conventional Commits:')
      ..writeln('  "$firstLine"')
      ..writeln('')
      ..writeln('Expected: type(scope?): subject')
      ..writeln('Valid types: ${_validTypes.join(', ')}')
      ..writeln('Example: feat(auth): add biometric login');
    exitCode = 1;
    return;
  }
}
