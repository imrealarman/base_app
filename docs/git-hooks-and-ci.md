# Git hooks, commit conventions, and CI

## Git hooks (lefthook)

Hooks are configured in `lefthook.yml` and run via
[lefthook](https://github.com/evilmartians/lefthook) — a single static binary, not an npm
package, so using it doesn't pull Node into a pure-Dart project.

**Install lefthook** (once per machine):

```
# macOS
brew install lefthook

# Windows (scoop)
scoop install lefthook

# Or via Go
go install github.com/evilmartians/lefthook@latest
```

**Enable the hooks in this repo** (once per clone):

```
lefthook install
```

What runs:

- **pre-commit**: `dart format --set-exit-if-changed` on staged `.dart` files, and
  `flutter analyze` — both must pass before a commit is created.
- **commit-msg**: validates the commit message against
  [Conventional Commits](https://www.conventionalcommits.org) via
  `dart run tool/cli/check_commit_msg.dart` (see below).
- **post-merge**: runs `flutter pub get` automatically if `pubspec.lock` changed after a
  pull/merge, so a teammate's new dependency doesn't silently go missing locally.

## Commit conventions

Commit messages must follow `type(scope?): subject`, where `type` is one of:

```
build, chore, ci, docs, feat, fix, perf, refactor, revert, style, test
```

Examples:

```
feat(auth): add biometric login
fix(settings): correct RTL padding on language tile
docs: add networking guide
```

This is enforced by the `commit-msg` hook (`tool/cli/check_commit_msg.dart`), and is what
tools like `cider` (see below) use to auto-generate changelogs from history.

## Versioning

`pubspec.yaml`'s `version: x.y.z+buildNumber` is the single source of truth for the app's
version (mirrored into native builds automatically by Flutter's tooling). To automate bumping
it based on Conventional Commits (analogous to the JS `np`/`semantic-release` tools), consider
adding [cider](https://pub.dev/packages/cider) — a Dart-native pub package purpose-built for
bumping `pubspec.yaml` versions and maintaining a changelog.

## CI (GitHub Actions)

`.github/workflows/ci.yml` has three jobs:

**`analyze-and-test`** runs on every push/PR to `main`:

1. Materializes `.env.dev`/`.env.staging`/`.env.prod` from the committed `.env.example` (the
   real files are gitignored — see [environments.md](environments.md)) and forces
   `STRICT_ENV_VALIDATION=true`, so a genuinely missing required key fails the build instead of
   just logging a warning.
2. `flutter pub get`
3. `dart run build_runner build --delete-conflicting-outputs` (generates Riverpod + slang code)
4. `dart format --set-exit-if-changed .` — fails if anything isn't formatted.
5. `flutter analyze` — fails on any analyzer issue.
6. `flutter test --coverage` — uploads `coverage/lcov.info` as a build artifact, then
   [`very_good_coverage`](https://github.com/VeryGoodOpenSource/very_good_coverage) fails the
   build if line coverage drops below `min_coverage` (50%, adjust as the suite grows).

**`build-android`** and **`build-ios`** run after `analyze-and-test` passes, and build an
unsigned debug artifact (`flutter build apk --debug`, `flutter build ios --debug
--no-codesign`) — this only proves the app still compiles for each platform (catches
Gradle/manifest/CocoaPods breakage), it is *not* a release pipeline. See below for that.

### Release workflow (not included, recommended pattern)

For an actual release pipeline, mirror this shape rather than reinventing it:

- **QA/preview builds**: auto-trigger on every merge to `main` or every tag, distributed via
  Firebase App Distribution (Android) / TestFlight internal testing (iOS).
- **Production builds**: manually triggered (`workflow_dispatch`), never automatic — someone
  has to deliberately promote a build to production.
- **Build backend**: Flutter has no single bundled equivalent of Expo's EAS Build; pick one of
  [Codemagic](https://codemagic.io) (hosted, Flutter-first), or Fastlane driven directly from
  GitHub Actions runners, depending on how much you want to self-host vs. outsource signing and
  build infra.
