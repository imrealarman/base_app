///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$en app = Translations$app$en._(_root);
	late final Translations$home$en home = Translations$home$en._(_root);
	late final Translations$settings$en settings = Translations$settings$en._(_root);
	late final Translations$posts$en posts = Translations$posts$en._(_root);
}

// Path: app
class Translations$app$en {
	Translations$app$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Base App'
	String get title => 'Base App';
}

// Path: home
class Translations$home$en {
	Translations$home$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Environment: $env'
	String environment({required Object env}) => 'Environment: ${env}';

	/// en: 'API: $url'
	String apiBaseUrl({required Object url}) => 'API: ${url}';

	/// en: 'Open settings'
	String get openSettings => 'Open settings';

	/// en: 'View posts (dio + Riverpod demo)'
	String get openPosts => 'View posts (dio + Riverpod demo)';

	/// en: 'Analytics: on'
	String get analyticsOn => 'Analytics: on';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Display name preview'
	String get displayNamePreview => 'Display name preview';

	/// en: 'Enter a display name'
	String get displayNameHint => 'Enter a display name';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Language'
	String get language => 'Language';

	late final Translations$settings$themeMode$en themeMode = Translations$settings$themeMode$en._(_root);
}

// Path: posts
class Translations$posts$en {
	Translations$posts$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Posts'
	String get title => 'Posts';

	/// en: 'Something went wrong loading posts.'
	String get error => 'Something went wrong loading posts.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: settings.themeMode
class Translations$settings$themeMode$en {
	Translations$settings$themeMode$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'System'
	String get system => 'System';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Base App',
			'home.environment' => ({required Object env}) => 'Environment: ${env}',
			'home.apiBaseUrl' => ({required Object url}) => 'API: ${url}',
			'home.openSettings' => 'Open settings',
			'home.openPosts' => 'View posts (dio + Riverpod demo)',
			'home.analyticsOn' => 'Analytics: on',
			'settings.title' => 'Settings',
			'settings.displayNamePreview' => 'Display name preview',
			'settings.displayNameHint' => 'Enter a display name',
			'settings.theme' => 'Theme',
			'settings.language' => 'Language',
			'settings.themeMode.system' => 'System',
			'settings.themeMode.light' => 'Light',
			'settings.themeMode.dark' => 'Dark',
			'posts.title' => 'Posts',
			'posts.error' => 'Something went wrong loading posts.',
			'posts.retry' => 'Retry',
			_ => null,
		};
	}
}
