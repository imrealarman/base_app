# Docs

Guides for customizing this template. Start with whichever matches what you're changing:

**App identity & UI**
- **[theming.md](theming.md)** — switch the built-in color swatch, or define your own brand colors.
- **[fonts.md](fonts.md)** — replace the app-wide font.
- **[icons-and-splash.md](icons-and-splash.md)** — replace the app icon and splash screen.
- **[renaming.md](renaming.md)** — rename the app, change its package/bundle id, and set RTL/LTR, all via the interactive CLI.

**App behavior**
- **[environments.md](environments.md)** — env vars, feature flags, and adding a new one.
- **[i18n.md](i18n.md)** — translations, language switching, adding a new language.
- **[networking.md](networking.md)** — the dio + Riverpod data-fetching pattern, with a worked example.
- **[error-handling.md](error-handling.md)** — the uncaught-error reporting hook, and logging conventions.

**Development workflow**
- **[code-generation.md](code-generation.md)** — when you must rerun `build_runner`, and why
  generated files are gitignored instead of committed.
- **[testing.md](testing.md)** — unit/widget tests, the `pumpApp` helper, mocking with mocktail.
- **[git-hooks-and-ci.md](git-hooks-and-ci.md)** — lefthook, commit conventions, GitHub Actions CI.

For the overall folder layout and how to add a new feature module, see the main [README.md](../README.md).
