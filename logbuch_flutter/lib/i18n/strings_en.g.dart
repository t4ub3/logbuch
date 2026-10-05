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
	late final Translations$tabs$en tabs = Translations$tabs$en.internal(_root);
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

// Path: tabs
class Translations$tabs$en {
	Translations$tabs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Close tab'
	String get close => 'Close tab';
}

// Path: menu
class Translations$menu$en {
	Translations$menu$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Calendar'
	String get calendar => 'Calendar';

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

	/// en: 'Previous year'
	String get previousYear => 'Previous year';

	/// en: 'Next year'
	String get nextYear => 'Next year';

	/// en: 'Today'
	String get today => 'Today';

	/// en: '+{n} more'
	String more({required Object n}) => '+${n} more';

	/// en: 'Yearly view'
	String get yearlyView => 'Yearly view';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Status'
	String get status => 'Status';

	late final Translations$bookings$statuses$en statuses = Translations$bookings$statuses$en.internal(_root);

	/// en: 'Edit booking'
	String get editBooking => 'Edit booking';

	/// en: 'Title'
	String get titleField => 'Title';

	/// en: 'Dates'
	String get dates => 'Dates';

	/// en: 'No dates'
	String get noDates => 'No dates';

	/// en: 'Clear dates'
	String get clearDates => 'Clear dates';

	/// en: 'Lead'
	String get leadField => 'Lead';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Saving failed: {error}'
	String saveFailed({required Object error}) => 'Saving failed: ${error}';
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

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'System default'
	String get systemTheme => 'System default';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'Accent color'
	String get accentColor => 'Accent color';
}

// Path: bookings.statuses
class Translations$bookings$statuses$en {
	Translations$bookings$statuses$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Requested'
	String get requested => 'Requested';

	/// en: 'Booked'
	String get booked => 'Booked';

	/// en: 'Billed'
	String get billed => 'Billed';

	/// en: 'Paid'
	String get paid => 'Paid';
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
			'tabs.home' => 'Home',
			'tabs.close' => 'Close tab',
			'menu.calendar' => 'Calendar',
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
			'bookings.previousYear' => 'Previous year',
			'bookings.nextYear' => 'Next year',
			'bookings.today' => 'Today',
			'bookings.more' => ({required Object n}) => '+${n} more',
			'bookings.yearlyView' => 'Yearly view',
			'bookings.edit' => 'Edit',
			'bookings.email' => 'Email',
			'bookings.phone' => 'Phone',
			'bookings.status' => 'Status',
			'bookings.statuses.requested' => 'Requested',
			'bookings.statuses.booked' => 'Booked',
			'bookings.statuses.billed' => 'Billed',
			'bookings.statuses.paid' => 'Paid',
			'bookings.editBooking' => 'Edit booking',
			'bookings.titleField' => 'Title',
			'bookings.dates' => 'Dates',
			'bookings.noDates' => 'No dates',
			'bookings.clearDates' => 'Clear dates',
			'bookings.leadField' => 'Lead',
			'bookings.required' => 'Required',
			'bookings.cancel' => 'Cancel',
			'bookings.save' => 'Save',
			'bookings.saveFailed' => ({required Object error}) => 'Saving failed: ${error}',
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
			'settings.theme' => 'Theme',
			'settings.systemTheme' => 'System default',
			'settings.light' => 'Light',
			'settings.dark' => 'Dark',
			'settings.accentColor' => 'Accent color',
			_ => null,
		};
	}
}
