///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fa,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fa>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFa _root = this; // ignore: unused_field

	@override 
	TranslationsFa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFa(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$fa app = _Translations$app$fa._(_root);
	@override late final _Translations$home$fa home = _Translations$home$fa._(_root);
	@override late final _Translations$settings$fa settings = _Translations$settings$fa._(_root);
	@override late final _Translations$posts$fa posts = _Translations$posts$fa._(_root);
}

// Path: app
class _Translations$app$fa implements Translations$app$en {
	_Translations$app$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get title => 'اپ پایه';
}

// Path: home
class _Translations$home$fa implements Translations$home$en {
	_Translations$home$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String environment({required Object env}) => 'محیط: ${env}';
	@override String apiBaseUrl({required Object url}) => 'آدرس API: ${url}';
	@override String get openSettings => 'باز کردن تنظیمات';
	@override String get openPosts => 'مشاهده پست‌ها (نمونه dio + Riverpod)';
	@override String get analyticsOn => 'تحلیل: فعال';
}

// Path: settings
class _Translations$settings$fa implements Translations$settings$en {
	_Translations$settings$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get title => 'تنظیمات';
	@override String get displayNamePreview => 'پیش‌نمایش نام نمایشی';
	@override String get displayNameHint => 'یک نام نمایشی وارد کنید';
	@override String get theme => 'پوسته';
	@override String get language => 'زبان';
	@override late final _Translations$settings$themeMode$fa themeMode = _Translations$settings$themeMode$fa._(_root);
}

// Path: posts
class _Translations$posts$fa implements Translations$posts$en {
	_Translations$posts$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get title => 'پست‌ها';
	@override String get error => 'بارگذاری پست‌ها با خطا مواجه شد.';
	@override String get errorNetwork => 'اتصال اینترنت وجود ندارد. اتصال خود را بررسی کرده و دوباره تلاش کنید.';
	@override String get errorTimeout => 'زمان درخواست به پایان رسید. لطفاً دوباره تلاش کنید.';
	@override String get errorNotFound => 'پست‌ها یافت نشدند.';
	@override String get errorServer => 'سرور با مشکل مواجه شد. لطفاً بعداً دوباره تلاش کنید.';
	@override String get retry => 'تلاش مجدد';
}

// Path: settings.themeMode
class _Translations$settings$themeMode$fa implements Translations$settings$themeMode$en {
	_Translations$settings$themeMode$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get system => 'سیستم';
	@override String get light => 'روشن';
	@override String get dark => 'تیره';
}

/// The flat map containing all translations for locale <fa>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'اپ پایه',
			'home.environment' => ({required Object env}) => 'محیط: ${env}',
			'home.apiBaseUrl' => ({required Object url}) => 'آدرس API: ${url}',
			'home.openSettings' => 'باز کردن تنظیمات',
			'home.openPosts' => 'مشاهده پست‌ها (نمونه dio + Riverpod)',
			'home.analyticsOn' => 'تحلیل: فعال',
			'settings.title' => 'تنظیمات',
			'settings.displayNamePreview' => 'پیش‌نمایش نام نمایشی',
			'settings.displayNameHint' => 'یک نام نمایشی وارد کنید',
			'settings.theme' => 'پوسته',
			'settings.language' => 'زبان',
			'settings.themeMode.system' => 'سیستم',
			'settings.themeMode.light' => 'روشن',
			'settings.themeMode.dark' => 'تیره',
			'posts.title' => 'پست‌ها',
			'posts.error' => 'بارگذاری پست‌ها با خطا مواجه شد.',
			'posts.errorNetwork' => 'اتصال اینترنت وجود ندارد. اتصال خود را بررسی کرده و دوباره تلاش کنید.',
			'posts.errorTimeout' => 'زمان درخواست به پایان رسید. لطفاً دوباره تلاش کنید.',
			'posts.errorNotFound' => 'پست‌ها یافت نشدند.',
			'posts.errorServer' => 'سرور با مشکل مواجه شد. لطفاً بعداً دوباره تلاش کنید.',
			'posts.retry' => 'تلاش مجدد',
			_ => null,
		};
	}
}
