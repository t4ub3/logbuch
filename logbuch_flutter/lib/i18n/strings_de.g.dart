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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$tabs$de tabs = _Translations$tabs$de._(_root);
	@override late final _Translations$menu$de menu = _Translations$menu$de._(_root);
	@override late final _Translations$bookings$de bookings = _Translations$bookings$de._(_root);
	@override late final _Translations$contacts$de contacts = _Translations$contacts$de._(_root);
	@override late final _Translations$rooms$de rooms = _Translations$rooms$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String loadFailed({required Object error}) => 'Laden fehlgeschlagen: ${error}';
	@override String get retry => 'Erneut versuchen';
	@override String get noEntries => 'Keine Einträge';
}

// Path: tabs
class _Translations$tabs$de extends Translations$tabs$en {
	_Translations$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Start';
	@override String get close => 'Tab schließen';
}

// Path: menu
class _Translations$menu$de extends Translations$menu$en {
	_Translations$menu$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get calendar => 'Kalender';
	@override String get contacts => 'Kontakte';
	@override String get rooms => 'Zimmer';
	@override String get settings => 'Einstellungen';
}

// Path: bookings
class _Translations$bookings$de extends Translations$bookings$en {
	_Translations$bookings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newBooking => 'Neue Buchung';
	@override String get agenda => 'Agenda';
	@override String get month => 'Monat';
	@override String get year => 'Jahr';
	@override String get noUpcoming => 'Keine anstehenden Buchungen';
	@override String lead({required Object name}) => 'Leitung: ${name}';
	@override String get previousMonth => 'Vorheriger Monat';
	@override String get nextMonth => 'Nächster Monat';
	@override String get previousYear => 'Vorheriges Jahr';
	@override String get nextYear => 'Nächstes Jahr';
	@override String get today => 'Heute';
	@override String more({required Object n}) => '+${n} weitere';
	@override String get yearlyView => 'Jahresansicht';
	@override String get edit => 'Bearbeiten';
	@override String get email => 'E-Mail';
	@override String get phone => 'Telefon';
	@override String get status => 'Status';
	@override late final _Translations$bookings$statuses$de statuses = _Translations$bookings$statuses$de._(_root);
	@override String get editBooking => 'Buchung bearbeiten';
	@override String get titleField => 'Titel';
	@override String get dates => 'Zeitraum';
	@override String get noDates => 'Kein Zeitraum';
	@override String get clearDates => 'Zeitraum entfernen';
	@override String get leadField => 'Leitung';
	@override String get required => 'Pflichtfeld';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String saveFailed({required Object error}) => 'Speichern fehlgeschlagen: ${error}';
}

// Path: contacts
class _Translations$contacts$de extends Translations$contacts$en {
	_Translations$contacts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Kontakte';
}

// Path: rooms
class _Translations$rooms$de extends Translations$rooms$en {
	_Translations$rooms$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Zimmer';
	@override String room({required Object number}) => 'Zimmer ${number}';
	@override String beds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Bett',
		other: '${n} Betten',
	);
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override String get language => 'Sprache';
	@override String get systemLanguage => 'Systemstandard';
	@override String get startOfWeek => 'Erster Wochentag';
	@override String get monday => 'Montag';
	@override String get sunday => 'Sonntag';
	@override String get theme => 'Design';
	@override String get systemTheme => 'Systemstandard';
	@override String get light => 'Hell';
	@override String get dark => 'Dunkel';
	@override String get accentColor => 'Akzentfarbe';
}

// Path: bookings.statuses
class _Translations$bookings$statuses$de extends Translations$bookings$statuses$en {
	_Translations$bookings$statuses$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get requested => 'Angefragt';
	@override String get booked => 'Gebucht';
	@override String get billed => 'Abgerechnet';
	@override String get paid => 'Bezahlt';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.loadFailed' => ({required Object error}) => 'Laden fehlgeschlagen: ${error}',
			'common.retry' => 'Erneut versuchen',
			'common.noEntries' => 'Keine Einträge',
			'tabs.home' => 'Start',
			'tabs.close' => 'Tab schließen',
			'menu.calendar' => 'Kalender',
			'menu.contacts' => 'Kontakte',
			'menu.rooms' => 'Zimmer',
			'menu.settings' => 'Einstellungen',
			'bookings.newBooking' => 'Neue Buchung',
			'bookings.agenda' => 'Agenda',
			'bookings.month' => 'Monat',
			'bookings.year' => 'Jahr',
			'bookings.noUpcoming' => 'Keine anstehenden Buchungen',
			'bookings.lead' => ({required Object name}) => 'Leitung: ${name}',
			'bookings.previousMonth' => 'Vorheriger Monat',
			'bookings.nextMonth' => 'Nächster Monat',
			'bookings.previousYear' => 'Vorheriges Jahr',
			'bookings.nextYear' => 'Nächstes Jahr',
			'bookings.today' => 'Heute',
			'bookings.more' => ({required Object n}) => '+${n} weitere',
			'bookings.yearlyView' => 'Jahresansicht',
			'bookings.edit' => 'Bearbeiten',
			'bookings.email' => 'E-Mail',
			'bookings.phone' => 'Telefon',
			'bookings.status' => 'Status',
			'bookings.statuses.requested' => 'Angefragt',
			'bookings.statuses.booked' => 'Gebucht',
			'bookings.statuses.billed' => 'Abgerechnet',
			'bookings.statuses.paid' => 'Bezahlt',
			'bookings.editBooking' => 'Buchung bearbeiten',
			'bookings.titleField' => 'Titel',
			'bookings.dates' => 'Zeitraum',
			'bookings.noDates' => 'Kein Zeitraum',
			'bookings.clearDates' => 'Zeitraum entfernen',
			'bookings.leadField' => 'Leitung',
			'bookings.required' => 'Pflichtfeld',
			'bookings.cancel' => 'Abbrechen',
			'bookings.save' => 'Speichern',
			'bookings.saveFailed' => ({required Object error}) => 'Speichern fehlgeschlagen: ${error}',
			'contacts.empty' => 'Keine Kontakte',
			'rooms.empty' => 'Keine Zimmer',
			'rooms.room' => ({required Object number}) => 'Zimmer ${number}',
			'rooms.beds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Bett', other: '${n} Betten', ), 
			'settings.title' => 'Einstellungen',
			'settings.language' => 'Sprache',
			'settings.systemLanguage' => 'Systemstandard',
			'settings.startOfWeek' => 'Erster Wochentag',
			'settings.monday' => 'Montag',
			'settings.sunday' => 'Sonntag',
			'settings.theme' => 'Design',
			'settings.systemTheme' => 'Systemstandard',
			'settings.light' => 'Hell',
			'settings.dark' => 'Dunkel',
			'settings.accentColor' => 'Akzentfarbe',
			_ => null,
		};
	}
}
