import 'dart:io';

/// Short entrypoint aliases for `flutter run -t lib/main_<env>.dart`, since
/// Flutter's CLI has no `flutter run:dev`-style subcommand support.
///
/// Usage:
///   dart run tool/cli/run.dart dev
///   dart run tool/cli/run.dart staging
///   dart run tool/cli/run.dart prod
///
/// Any extra arguments are forwarded to `flutter run` as-is, e.g.:
///   dart run tool/cli/run.dart dev -d chrome
///   dart run tool/cli/run.dart prod --release
const _entrypoints = {
  'dev': 'lib/main_dev.dart',
  'staging': 'lib/main_staging.dart',
  'prod': 'lib/main_prod.dart',
};

Future<void> main(List<String> args) async {
  if (args.isEmpty || !_entrypoints.containsKey(args.first)) {
    stderr.writeln(
      'Usage: dart run tool/cli/run.dart <${_entrypoints.keys.join('|')}> [flutter run args...]',
    );
    exitCode = 1;
    return;
  }

  final entrypoint = _entrypoints[args.first]!;
  final passthroughArgs = args.skip(1).toList();

  final process = await Process.start(
    'flutter',
    ['run', '-t', entrypoint, ...passthroughArgs],
    mode: ProcessStartMode.inheritStdio,
    runInShell: true,
  );

  exitCode = await process.exitCode;
}
