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
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$menu$en menu = Translations$menu$en.internal(_root);
	late final Translations$bookings$en bookings = Translations$bookings$en.internal(_root);
	late final Translations$contacts$en contacts = Translations$contacts$en.internal(_root);
	late final Translations$rooms$en rooms = Translations$rooms$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load: {error}'
	String loadFailed({required Object error}) => 'Failed to load: ${error}';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'No entries'
	String get noEntries => 'No entries';
}

// Path: menu
class Translations$menu$en {
	Translations$menu$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Bookings'
	String get bookings => 'Bookings';

	/// en: 'Contacts'
	String get contacts => 'Contacts';

	/// en: 'Rooms'
	String get rooms => 'Rooms';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: bookings
class Translations$bookings$en {
	Translations$bookings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New booking'
	String get newBooking => 'New booking';

	/// en: 'Agenda'
	String get agenda => 'Agenda';

	/// en: 'Month'
	String get month => 'Month';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'No upcoming bookings'
	String get noUpcoming => 'No upcoming bookings';

	/// en: 'Lead: {name}'
	String lead({required Object name}) => 'Lead: ${name}';

	/// en: 'Previous month'
	String get previousMonth => 'Previous month';

	/// en: 'Next month'
	String get nextMonth => 'Next month';

	/// en: 'Today'
	String get today => 'Today';

	/// en: '+{n} more'
	String more({required Object n}) => '+${n} more';

	/// en: 'Yearly view'
	String get yearlyView => 'Yearly view';
}

// Path: contacts
class Translations$contacts$en {
	Translations$contacts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No contacts'
	String get empty => 'No contacts';
}

// Path: rooms
class Translations$rooms$en {
	Translations$rooms$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No rooms'
	String get empty => 'No rooms';

	/// en: 'Room {number}'
	String room({required Object number}) => 'Room ${number}';

	/// en: '(one) {{n} bed} (other) {{n} beds}'
	String beds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} bed',
		other: '${n} beds',
	);
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'System default'
	String get systemLanguage => 'System default';

	/// en: 'First day of the week'
	String get startOfWeek => 'First day of the week';

	/// en: 'Monday'
	String get monday => 'Monday';

	/// en: 'Sunday'
	String get sunday => 'Sunday';

	/// en: 'Accent color'
	String get accentColor => 'Accent color';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.loadFailed' => ({required Object error}) => 'Failed to load: ${error}',
			'common.retry' => 'Retry',
			'common.noEntries' => 'No entries',
			'menu.bookings' => 'Bookings',
			'menu.contacts' => 'Contacts',
			'menu.rooms' => 'Rooms',
			'menu.settings' => 'Settings',
			'bookings.newBooking' => 'New booking',
			'bookings.agenda' => 'Agenda',
			'bookings.month' => 'Month',
			'bookings.year' => 'Year',
			'bookings.noUpcoming' => 'No upcoming bookings',
			'bookings.lead' => ({required Object name}) => 'Lead: ${name}',
			'bookings.previousMonth' => 'Previous month',
			'bookings.nextMonth' => 'Next month',
			'bookings.today' => 'Today',
			'bookings.more' => ({required Object n}) => '+${n} more',
			'bookings.yearlyView' => 'Yearly view',
			'contacts.empty' => 'No contacts',
			'rooms.empty' => 'No rooms',
			'rooms.room' => ({required Object number}) => 'Room ${number}',
			'rooms.beds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} bed', other: '${n} beds', ), 
			'settings.title' => 'Settings',
			'settings.language' => 'Language',
			'settings.systemLanguage' => 'System default',
			'settings.startOfWeek' => 'First day of the week',
			'settings.monday' => 'Monday',
			'settings.sunday' => 'Sunday',
			'settings.accentColor' => 'Accent color',
			_ => null,
		};
	}
}
