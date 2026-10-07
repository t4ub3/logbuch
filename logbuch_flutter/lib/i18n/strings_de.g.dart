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
	@override late final _Translations$admin$de admin = _Translations$admin$de._(_root);
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$donations$de donations = _Translations$donations$de._(_root);
	@override late final _Translations$dashboard$de dashboard = _Translations$dashboard$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$status$de status = _Translations$status$de._(_root);
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String loadFailed({required Object error}) => 'Laden fehlgeschlagen: ${error}';
	@override String get retry => 'Erneut versuchen';
	@override String get noEntries => 'Keine Einträge';
	@override String get edit => 'Bearbeiten';
	@override String get delete => 'Löschen';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get discard => 'Verwerfen';
	@override String get required => 'Pflichtfeld';
	@override String get name => 'Name';
	@override String saveFailed({required Object error}) => 'Speichern fehlgeschlagen: ${error}';
	@override String deleteFailed({required Object error}) => 'Löschen fehlgeschlagen: ${error}';
	@override String get none => 'Keine Angabe';
	@override String get search => 'Suchen';
	@override String get signOut => 'Abmelden';
	@override String get clear => 'Entfernen';
	@override String get close => 'Schließen';
	@override String get copy => 'Kopieren';
	@override String get copied => 'Kopiert';
}

// Path: tabs
class _Translations$tabs$de extends Translations$tabs$en {
	_Translations$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get close => 'Tab schließen';
}

// Path: menu
class _Translations$menu$de extends Translations$menu$en {
	_Translations$menu$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get calendar => 'Kalender';
	@override String get contacts => 'Kontakte';
	@override String get admin => 'Verwaltung';
	@override String get settings => 'Einstellungen';
	@override String get donations => 'Spenden';
	@override String get dashboard => 'Übersicht';
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
	@override String get occupancy => 'Belegung';
	@override String get overview => 'Übersicht';
	@override String get rooms => 'Zimmer';
	@override String get organization => 'Organisation';
	@override String get mealPlan => 'Verpflegung';
	@override String get billingMode => 'Rechnungen';
	@override late final _Translations$bookings$billingModes$de billingModes = _Translations$bookings$billingModes$de._(_root);
	@override String get expectedGuests => 'Erwartete Gäste';
	@override String get optionExpiresAt => 'Option gültig bis';
	@override String get notes => 'Notizen';
	@override String get roomsNeedDates => 'Bitte zuerst den Zeitraum der Buchung festlegen, um Zimmer auszuwählen.';
	@override String get noFreeRooms => 'In diesem Zeitraum sind keine Zimmer frei.';
	@override String selectedBeds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Bett ausgewählt',
		other: '${n} Betten ausgewählt',
	);
	@override String guestsExpected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Gast erwartet',
		other: '${n} Gäste erwartet',
	);
	@override String get guests => 'Gäste';
	@override String get assignment => 'Verteilung';
	@override String get price => 'Preis';
	@override String get noGroups => 'Noch keine Gäste. Beginnen Sie mit einer Gruppe, zum Beispiel einer Familie.';
	@override String get addGroup => 'Neue Gruppe';
	@override String get editGroup => 'Gruppe bearbeiten';
	@override String get payer => 'Zahlt für die Gruppe';
	@override String get deleteGroupHint => 'Ihre Gäste werden aus der Buchung entfernt. Die Kontakte bleiben erhalten.';
	@override String get addGuest => 'Gast hinzufügen';
	@override String get editGuest => 'Gast bearbeiten';
	@override String get removeGuestHint => 'Der Gast wird aus der Buchung entfernt. Der Kontakt bleibt erhalten.';
	@override String get existingContact => 'Vorhandener Kontakt';
	@override String get newContact => 'Neuer Kontakt';
	@override String get contact => 'Kontakt';
	@override String get needsCrib => 'Schläft im Kinderbett';
	@override String get crib => 'Kinderbett';
	@override String get ageGroup => 'Altersgruppe';
	@override String get ageByBirthDate => 'Nach Geburtsdatum';
	@override String get ageUnknown => 'Alter unbekannt';
	@override String get dietaryNotes => 'Ernährungshinweise';
	@override String get arrivalOverride => 'Reist später an, am';
	@override String get departureOverride => 'Reist früher ab, am';
	@override String guestCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Gast',
		other: '${n} Gäste',
	);
	@override String get unassigned => 'Ohne Zimmer';
	@override String get everybodyAssigned => 'Alle haben ein Zimmer.';
	@override String get noRoomsHeld => 'Die Buchung hat noch keine Zimmer.';
	@override String get moveTo => 'Verschieben nach';
	@override String bedsUsed({required Object used, required Object beds}) => '${used} von ${beds} Betten';
	@override String get roomFull => 'Voll';
	@override String freeBeds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} freies Bett',
		other: '${n} freie Betten',
	);
	@override String get roomOverfull => 'Mehr Gäste als Betten';
	@override String get roomNoCrib => 'Hier kann kein Kinderbett aufgestellt werden';
	@override String get total => 'Gesamt';
	@override String get inclTax => 'Alle Preise enthalten die Steuer.';
	@override String get nothingToPrice => 'Noch nichts zu berechnen.';
	@override String get wholeBooking => 'Gesamte Buchung';
	@override late final _Translations$bookings$chargeTypes$de chargeTypes = _Translations$bookings$chargeTypes$de._(_root);
	@override late final _Translations$bookings$pricingProblems$de pricingProblems = _Translations$bookings$pricingProblems$de._(_root);
	@override String get billing => 'Abrechnung';
	@override String get noFolios => 'Noch nichts abzurechnen. Bitte zuerst Gäste hinzufügen und auf Zimmer verteilen.';
	@override String get folioOpen => 'Noch keine Rechnung';
	@override String folioInvoiced({required Object number, required Object date}) => 'Rechnung ${number} vom ${date}';
	@override String get stillToPay => 'Noch zu zahlen';
	@override String get paidInFull => 'Vollständig bezahlt';
	@override String get overpaid => 'Überzahlt';
	@override String get decide => 'Entscheiden';
	@override String get recordPayment => 'Zahlung erfassen';
	@override String get addCharge => 'Position hinzufügen';
	@override String get createInvoice => 'Rechnung erstellen';
	@override String get createInvoiceHint => 'Die Abrechnung erhält die nächste Rechnungsnummer. Ihre Positionen können danach nicht mehr geändert werden.';
	@override String get payment => 'Zahlung';
	@override String get refund => 'Erstattung';
	@override String get donation => 'Spende';
	@override String get amount => 'Betrag';
	@override String get date => 'Datum';
	@override String get paymentMethod => 'Bezahlt per';
	@override late final _Translations$bookings$paymentMethods$de paymentMethods = _Translations$bookings$paymentMethods$de._(_root);
	@override String get reference => 'Verwendungszweck';
	@override String overpaidTitle({required Object amount}) => '${amount} überzahlt';
	@override String overpaidText({required Object name}) => 'Was soll mit diesem Geld geschehen? Eine Spende bitte nur erfassen, wenn ${name} das Geld ausdrücklich als Spende überlässt.';
	@override String get asDonation => 'Als Spende erfassen';
	@override String get asRefund => 'Erstatten';
	@override String get asCredit => 'Als Guthaben behalten';
	@override String get removePaymentHint => 'Bitte nur Zahlungen entfernen, die versehentlich erfasst wurden.';
	@override String get removeDonationHint => 'Das Geld gilt dann wieder als überzahlt.';
	@override String get description => 'Beschreibung';
	@override String get quantity => 'Anzahl';
	@override String get unitPrice => 'Einzelpreis';
	@override String get isDiscount => 'Das ist ein Rabatt';
	@override String get taxRate => 'Steuersatz';
	@override String get openInvoice => 'Rechnung öffnen';
	@override String openInvoiceFailed({required Object error}) => 'Die Rechnung konnte nicht geöffnet werden: ${error}';
	@override String get renewInvoice => 'Dokument erneuern';
	@override String get renewInvoiceHint => 'Die Rechnung wird mit den aktuellen Angaben, etwa der Bankverbindung, neu erstellt und ersetzt das gespeicherte Dokument. Bitte nur, solange die Rechnung noch nicht verschickt wurde.';
	@override String get kitchen => 'Küche';
	@override String get guestsByAge => 'Gäste nach Altersgruppe';
	@override String get guestsInTotal => 'Gäste insgesamt';
	@override String get noMealPlan => 'Keine gewählt';
	@override String get noDietaryNeeds => 'Für die Gäste sind keine Ernährungshinweise erfasst.';
	@override String get addHousehold => 'Haushalt hinzufügen';
	@override String get noHouseholdsYet => 'Es gibt noch keine Haushalte. Sie werden unter Kontakte, Haushalte angelegt.';
	@override String get confirmation => 'Bestätigung';
	@override String openConfirmationFailed({required Object error}) => 'Die Bestätigung konnte nicht geöffnet werden: ${error}';
	@override String bedsInRooms({required Object beds, required Object rooms}) => '${beds} in ${rooms}';
}

// Path: contacts
class _Translations$contacts$de extends Translations$contacts$en {
	_Translations$contacts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Kontakte';
	@override String get people => 'Personen';
	@override String get organizations => 'Organisationen';
	@override String get add => 'Neuer Kontakt';
	@override String get edit => 'Kontakt bearbeiten';
	@override String get searchHint => 'Kontakte suchen';
	@override String get noMatches => 'Keine passenden Kontakte';
	@override String get firstName => 'Vorname';
	@override String get lastName => 'Nachname';
	@override String get nameRequired => 'Bitte Vor- oder Nachnamen angeben';
	@override String get birthDate => 'Geburtsdatum';
	@override String get email => 'E-Mail';
	@override String get phone => 'Telefon';
	@override String get street => 'Straße';
	@override String get zip => 'Postleitzahl';
	@override String get city => 'Ort';
	@override String get country => 'Land';
	@override String get organization => 'Organisation';
	@override String get notes => 'Notizen';
	@override String get privacyConsent => 'Hat der Speicherung der Daten zugestimmt';
	@override String get noOrganizations => 'Keine Organisationen';
	@override String get addOrganization => 'Neue Organisation';
	@override String get editOrganization => 'Organisation bearbeiten';
	@override String get deleteOrganizationHint => 'Ihre Kontakte bleiben erhalten, ohne Organisation.';
	@override String get households => 'Haushalte';
	@override String get noHouseholds => 'Keine Haushalte';
	@override String get addHousehold => 'Neuer Haushalt';
	@override String get editHousehold => 'Haushalt bearbeiten';
	@override String get addMember => 'Mitglied hinzufügen';
	@override String get noMembers => 'Noch keine Mitglieder';
	@override String get deleteHouseholdHint => 'Die Mitglieder bleiben als Kontakte erhalten.';
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

// Path: admin
class _Translations$admin$de extends Translations$admin$en {
	_Translations$admin$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$admin$sections$de sections = _Translations$admin$sections$de._(_root);
	@override String deleteTitle({required Object name}) => '„${name}“ löschen?';
	@override String get invalidNumber => 'Bitte eine ganze Zahl eingeben';
	@override String get invalidAmount => 'Bitte einen Betrag wie 12,50 eingeben';
	@override late final _Translations$admin$errors$de errors = _Translations$admin$errors$de._(_root);
	@override late final _Translations$admin$rooms$de rooms = _Translations$admin$rooms$de._(_root);
	@override late final _Translations$admin$priceCategories$de priceCategories = _Translations$admin$priceCategories$de._(_root);
	@override late final _Translations$admin$ageGroups$de ageGroups = _Translations$admin$ageGroups$de._(_root);
	@override late final _Translations$admin$seasons$de seasons = _Translations$admin$seasons$de._(_root);
	@override late final _Translations$admin$mealPlans$de mealPlans = _Translations$admin$mealPlans$de._(_root);
	@override late final _Translations$admin$rates$de rates = _Translations$admin$rates$de._(_root);
	@override late final _Translations$admin$fees$de fees = _Translations$admin$fees$de._(_root);
	@override late final _Translations$admin$users$de users = _Translations$admin$users$de._(_root);
	@override late final _Translations$admin$operator$de operator = _Translations$admin$operator$de._(_root);
}

// Path: auth
class _Translations$auth$de extends Translations$auth$en {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get waitingTitle => 'Warten auf Freigabe';
	@override String waitingText({required Object email}) => 'Ihr Konto ${email} hat noch keine Rolle. Ein Admin muss den Zugriff freigeben.';
	@override String get checkAgain => 'Erneut prüfen';
	@override String get account => 'Konto';
	@override late final _Translations$auth$roles$de roles = _Translations$auth$roles$de._(_root);
}

// Path: donations
class _Translations$donations$de extends Translations$donations$en {
	_Translations$donations$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object year}) => 'Spenden ${year}';
	@override String empty({required Object year}) => 'Keine Spenden in ${year}';
	@override String get add => 'Neue Spende';
	@override String get donor => 'Spender';
	@override String get amount => 'Betrag';
	@override String get date => 'Datum';
	@override String get fromPayment => 'Rest einer Zahlung';
	@override String get total => 'Gesamt';
	@override String get noReceipt => 'Noch keine Bestätigung';
	@override String get receipts => 'Zuwendungsbestätigungen';
	@override String get createReceipts => 'Bestätigungen erstellen';
	@override String previewTitle({required Object year}) => 'Zuwendungsbestätigungen für ${year}';
	@override String get previewHint => 'Jeder Spender erhält eine Bestätigung über alle Spenden des Jahres, die noch auf keiner Bestätigung stehen. Danach können diese Spenden nicht mehr geändert werden.';
	@override String previewNone({required Object year}) => 'Keine Spende aus ${year} wartet auf eine Bestätigung.';
	@override String donationCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Spende',
		other: '${n} Spenden',
	);
	@override String get addressMissing => 'Keine Bestätigung: Die Anschrift ist unvollständig';
	@override String created({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Keine Bestätigungen erstellt',
		one: '${n} Bestätigung erstellt',
		other: '${n} Bestätigungen erstellt',
	);
	@override String get openPdf => 'PDF öffnen';
	@override String openFailed({required Object error}) => 'Die Bestätigung konnte nicht geöffnet werden: ${error}';
}

// Path: dashboard
class _Translations$dashboard$de extends Translations$dashboard$en {
	_Translations$dashboard$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get arrivals => 'Anreisen in den nächsten 7 Tagen';
	@override String get noArrivals => 'In den nächsten 7 Tagen reist niemand an.';
	@override String get departures => 'Abreisen in den nächsten 7 Tagen';
	@override String get noDepartures => 'In den nächsten 7 Tagen reist niemand ab.';
	@override String get tonight => 'Heute Nacht';
	@override String roomsOccupied({required Object occupied, required Object total}) => '${occupied} von ${total} Zimmern belegt';
	@override String guestsTonight({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Keine Gäste im Haus',
		one: '${n} Gast im Haus',
		other: '${n} Gäste im Haus',
	);
	@override String roomCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Zimmer',
		other: '${n} Zimmer',
	);
	@override String get options => 'Bald ablaufende Optionen';
	@override String get noOptions => 'In den nächsten 14 Tagen läuft keine Option ab.';
	@override String expires({required Object date}) => 'Läuft ab am ${date}';
	@override String expired({required Object date}) => 'Abgelaufen am ${date}';
	@override String get balances => 'Unbezahlte Rechnungen';
	@override String get noBalances => 'Keine Rechnung wartet auf Zahlung.';
	@override String get catering => 'Zu verpflegende Gäste';
	@override String get today => 'Heute';
	@override String get tomorrow => 'Morgen';
	@override String get noGuests => 'Keine Gäste.';
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

// Path: status
class _Translations$status$de extends Translations$status$en {
	_Translations$status$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Daten werden geladen …';
	@override String get loaded => 'Daten geladen';
	@override String get saved => 'Gespeichert';
	@override String get deleted => 'Gelöscht';
	@override String documentCreated({required Object name}) => 'Dokument erstellt: ${name}';
}

// Path: bookings.statuses
class _Translations$bookings$statuses$de extends Translations$bookings$statuses$en {
	_Translations$bookings$statuses$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get inquiry => 'Anfrage';
	@override String get option => 'Option';
	@override String get confirmed => 'Bestätigt';
	@override String get checkedIn => 'Angereist';
	@override String get completed => 'Abgeschlossen';
	@override String get cancelled => 'Storniert';
}

// Path: bookings.billingModes
class _Translations$bookings$billingModes$de extends Translations$bookings$billingModes$en {
	_Translations$bookings$billingModes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get single => 'Eine Rechnung für die Buchung';
	@override String get perGroup => 'Eine Rechnung pro Gruppe';
	@override String get perGuest => 'Eine Rechnung pro Gast';
}

// Path: bookings.chargeTypes
class _Translations$bookings$chargeTypes$de extends Translations$bookings$chargeTypes$en {
	_Translations$bookings$chargeTypes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get lodging => 'Übernachtung';
	@override String get meal => 'Verpflegung';
	@override String get fee => 'Gebühr';
	@override String get discount => 'Rabatt';
	@override String get manual => 'Sonstiges';
}

// Path: bookings.pricingProblems
class _Translations$bookings$pricingProblems$de extends Translations$bookings$pricingProblems$en {
	_Translations$bookings$pricingProblems$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get datesMissing => 'Die Buchung hat keinen Zeitraum.';
	@override String ageUnknown({required Object name}) => '${name}: Das Alter ist nicht bekannt. Bitte Geburtsdatum eintragen oder Altersgruppe wählen.';
	@override String roomMissing({required Object name}) => '${name}: hat noch kein Zimmer.';
	@override String seasonMissing({required Object date}) => 'Für den ${date} gibt es keine Saison.';
	@override String roomRateMissing({required Object detail}) => 'Kein Übernachtungspreis für ${detail}.';
	@override String mealRateMissing({required Object detail}) => 'Kein Verpflegungspreis für ${detail}.';
}

// Path: bookings.paymentMethods
class _Translations$bookings$paymentMethods$de extends Translations$bookings$paymentMethods$en {
	_Translations$bookings$paymentMethods$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cash => 'Bar';
	@override String get bankTransfer => 'Überweisung';
	@override String get card => 'Karte';
	@override String get other => 'Sonstiges';
}

// Path: admin.sections
class _Translations$admin$sections$de extends Translations$admin$sections$en {
	_Translations$admin$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get rooms => 'Zimmer';
	@override String get priceCategories => 'Preiskategorien';
	@override String get ageGroups => 'Altersgruppen';
	@override String get seasons => 'Saisons';
	@override String get mealPlans => 'Verpflegung';
	@override String get rates => 'Preise';
	@override String get fees => 'Gebühren';
	@override String get users => 'Benutzer';
	@override String get operator => 'Träger';
}

// Path: admin.errors
class _Translations$admin$errors$de extends Translations$admin$errors$en {
	_Translations$admin$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'Ein Name ist erforderlich.';
	@override String get invalidDate => 'Das Datum ist ungültig.';
	@override String get invalidDateRange => 'Das Ende darf nicht vor dem Beginn liegen.';
	@override String seasonOverlap({required Object name}) => 'Der Zeitraum überschneidet sich mit der Saison „${name}“.';
	@override String get invalidAgeRange => 'Das Höchstalter darf nicht unter dem Mindestalter liegen.';
	@override String ageGroupOverlap({required Object name}) => 'Die Altersangaben überschneiden sich mit der Altersgruppe „${name}“.';
	@override String get invalidAmount => 'Beträge dürfen nicht negativ sein.';
	@override String get invalidTaxRate => 'Der Steuersatz muss zwischen 0 und 100 % liegen.';
	@override String get invalidBedAmount => 'Die Bettenzahl darf nicht negativ sein.';
	@override String get duplicateRate => 'Ein Preis wurde doppelt angegeben.';
	@override String get inUse => 'Dieser Eintrag wird noch verwendet und kann nicht gelöscht werden.';
	@override String get invalidGuestCount => 'Die Gästezahl darf nicht negativ sein.';
	@override String get notFound => 'Dieser Eintrag existiert nicht mehr.';
	@override String get datesRequired => 'Eine Buchung mit Zimmern braucht einen Zeitraum.';
	@override String roomUnavailable({required Object name}) => 'In diesem Zeitraum nicht frei: Zimmer ${name}.';
	@override String get adminRequired => 'Nur Admins können Daten ändern.';
	@override String get ownRole => 'Die eigene Rolle kann nicht geändert werden.';
	@override String get roomNotHeld => 'Die Buchung hat dieses Zimmer nicht.';
	@override String get alreadyInvoiced => 'Das ist bereits in Rechnung gestellt und kann nicht mehr geändert werden.';
	@override String get nothingToInvoice => 'Es gibt nichts abzurechnen.';
	@override String get pricingIncomplete => 'Teile der Buchung können noch nicht berechnet werden. Was fehlt, steht beim Preis.';
	@override String get notOverpaid => 'Das ist mehr, als überzahlt wurde.';
	@override String get alreadyReceipted => 'Diese Spende steht auf einer Bestätigung und kann nicht mehr geändert werden.';
	@override String get operatorIncomplete => 'Die Angaben zum Träger sind unvollständig. Bitte unter Verwaltung, Träger ergänzen.';
	@override String get alreadyGuest => 'Aus diesem Haushalt kann niemand hinzugefügt werden: Er hat keine Mitglieder, oder alle sind bereits Gäste der Buchung.';
	@override String get notConfirmed => 'Eine Bestätigung gibt es nur für Buchungen, die eine Option oder bestätigt sind.';
}

// Path: admin.rooms
class _Translations$admin$rooms$de extends Translations$admin$rooms$en {
	_Translations$admin$rooms$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get add => 'Neues Zimmer';
	@override String get edit => 'Zimmer bearbeiten';
	@override String get number => 'Zimmernummer';
	@override String get beds => 'Betten';
	@override String get priceCategory => 'Preiskategorie';
	@override String get noPriceCategories => 'Bitte zuerst eine Preiskategorie anlegen.';
	@override String get building => 'Gebäude';
	@override String get floor => 'Etage';
	@override String get cribPossible => 'Ein Kinderbett kann aufgestellt werden';
	@override String get crib => 'Kinderbett möglich';
	@override String get active => 'Aktiv';
	@override String get activeHint => 'Inaktive Zimmer bleiben in früheren Buchungen erhalten, können aber nicht mehr gebucht werden.';
	@override String get inactive => 'Inaktiv';
	@override String get notes => 'Notizen';
}

// Path: admin.priceCategories
class _Translations$admin$priceCategories$de extends Translations$admin$priceCategories$en {
	_Translations$admin$priceCategories$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Preiskategorien';
	@override String get add => 'Neue Preiskategorie';
	@override String get edit => 'Preiskategorie bearbeiten';
	@override String get sortOrder => 'Position in Listen';
	@override String get deleteHint => 'Die Preise dieser Kategorie werden ebenfalls gelöscht.';
}

// Path: admin.ageGroups
class _Translations$admin$ageGroups$de extends Translations$admin$ageGroups$en {
	_Translations$admin$ageGroups$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Altersgruppen';
	@override String get add => 'Neue Altersgruppe';
	@override String get edit => 'Altersgruppe bearbeiten';
	@override String get minAge => 'Ab Alter';
	@override String get maxAge => 'Bis Alter';
	@override String get maxAgeHint => 'Leer für keine Obergrenze';
	@override String range({required Object min, required Object max}) => '${min} bis ${max} Jahre';
	@override String singleAge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Jahr',
		other: '${n} Jahre',
	);
	@override String openRange({required Object min}) => 'ab ${min} Jahren';
	@override String get deleteHint => 'Die Preise dieser Altersgruppe werden ebenfalls gelöscht.';
}

// Path: admin.seasons
class _Translations$admin$seasons$de extends Translations$admin$seasons$en {
	_Translations$admin$seasons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Saisons';
	@override String get add => 'Neue Saison';
	@override String get edit => 'Saison bearbeiten';
	@override String get period => 'Zeitraum';
	@override String gap({required Object from, required Object to}) => 'Für ${from} – ${to} gibt es keine Saison. Aufenthalte in diesem Zeitraum können nicht berechnet werden.';
	@override String get deleteHint => 'Die Preise dieser Saison werden ebenfalls gelöscht.';
}

// Path: admin.mealPlans
class _Translations$admin$mealPlans$de extends Translations$admin$mealPlans$en {
	_Translations$admin$mealPlans$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Verpflegungsarten';
	@override String get add => 'Neue Verpflegungsart';
	@override String get edit => 'Verpflegungsart bearbeiten';
	@override String get deleteHint => 'Die Preise dieser Verpflegungsart werden ebenfalls gelöscht.';
}

// Path: admin.rates
class _Translations$admin$rates$de extends Translations$admin$rates$en {
	_Translations$admin$rates$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get lodging => 'Übernachtung';
	@override String get meals => 'Verpflegung';
	@override String get priceCategory => 'Preiskategorie';
	@override String get mealPlan => 'Verpflegung';
	@override String get missingLodging => 'Für Preise werden mindestens eine Saison, eine Altersgruppe und eine Preiskategorie benötigt.';
	@override String get missingMeals => 'Für Preise werden mindestens eine Saison, eine Altersgruppe und eine Verpflegungsart benötigt.';
	@override String get hint => 'Preise pro Person und Nacht in Euro. Ein leeres Feld hat keinen Preis.';
	@override String get invalid => 'Bitte Beträge wie 12,50 eingeben.';
	@override String get saved => 'Preise gespeichert';
}

// Path: admin.fees
class _Translations$admin$fees$de extends Translations$admin$fees$en {
	_Translations$admin$fees$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Gebühren';
	@override String get add => 'Neue Gebühr';
	@override String get edit => 'Gebühr bearbeiten';
	@override String get amount => 'Betrag';
	@override String get unit => 'Berechnung';
	@override late final _Translations$admin$fees$units$de units = _Translations$admin$fees$units$de._(_root);
	@override String get ageGroup => 'Gilt für';
	@override String get allAges => 'Alle Altersgruppen';
	@override String get taxRate => 'Steuersatz';
	@override String tax({required Object rate}) => '${rate} % Steuer';
	@override String get autoApply => 'Zu jeder Buchung hinzufügen';
	@override String get autoApplyHint => 'Andernfalls wird die Gebühr einer Buchung von Hand hinzugefügt.';
	@override String get auto => 'jede Buchung';
}

// Path: admin.users
class _Translations$admin$users$de extends Translations$admin$users$en {
	_Translations$admin$users$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Benutzer';
	@override String get unknownEmail => 'Keine E-Mail-Adresse';
	@override String get you => 'Sie';
}

// Path: admin.operator
class _Translations$admin$operator$de extends Translations$admin$operator$en {
	_Translations$admin$operator$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Die Organisation, die das Haus betreibt. Diese Angaben stehen auf Rechnungen und Zuwendungsbestätigungen. Bestätigungen können erst erstellt werden, wenn alle Angaben zum Finanzamt ausgefüllt sind.';
	@override String get street => 'Straße';
	@override String get zip => 'Postleitzahl';
	@override String get city => 'Ort';
	@override String get taxOffice => 'Finanzamt';
	@override String get taxNumber => 'Steuernummer';
	@override String get noticeType => 'Bescheid des Finanzamts';
	@override String get exemptionNotice => 'Freistellungsbescheid';
	@override String get statutoryCompliance => 'Feststellungsbescheid nach § 60a AO';
	@override String get noticeDate => 'Datum des Bescheids';
	@override String get assessmentPeriod => 'Veranlagungszeitraum des Bescheids';
	@override String get purposes => 'Geförderte Zwecke, nach „zur Förderung“';
	@override String get purposesHint => 'Zum Beispiel: der Jugendhilfe';
	@override String get purposesObject => 'Geförderte Zwecke, nach „Wir fördern nach unserer Satzung“';
	@override String get purposesObjectHint => 'Zum Beispiel: die Jugendhilfe';
	@override String get place => 'Ort der Unterschrift';
	@override String get signatory => 'Unterzeichnet von';
	@override String get bankHint => 'Steht auf Rechnungen, damit klar ist, wohin und bis wann zu zahlen ist.';
	@override String get accountHolder => 'Kontoinhaber';
	@override String get iban => 'IBAN';
	@override String get bic => 'BIC';
	@override String get bankName => 'Bank';
	@override String get paymentTerms => 'Zahlungsbedingungen';
	@override String get paymentTermsHint => 'Zum Beispiel: Zahlbar innerhalb von 14 Tagen ohne Abzug.';
	@override String get confirmationNote => 'Hinweis auf Buchungsbestätigungen';
	@override String get confirmationNoteHint => 'Zum Beispiel, ab wann die Zimmer am Anreisetag bereitstehen.';
}

// Path: auth.roles
class _Translations$auth$roles$de extends Translations$auth$roles$en {
	_Translations$auth$roles$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get admin => 'Admin';
	@override String get viewer => 'Nur ansehen';
	@override String get none => 'Kein Zugriff';
}

// Path: admin.fees.units
class _Translations$admin$fees$units$de extends Translations$admin$fees$units$en {
	_Translations$admin$fees$units$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get perBooking => 'pro Buchung';
	@override String get perPerson => 'pro Person';
	@override String get perPersonNight => 'pro Person und Nacht';
	@override String get perRoom => 'pro Zimmer';
	@override String get perRoomNight => 'pro Zimmer und Nacht';
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
			'common.edit' => 'Bearbeiten',
			'common.delete' => 'Löschen',
			'common.cancel' => 'Abbrechen',
			'common.save' => 'Speichern',
			'common.discard' => 'Verwerfen',
			'common.required' => 'Pflichtfeld',
			'common.name' => 'Name',
			'common.saveFailed' => ({required Object error}) => 'Speichern fehlgeschlagen: ${error}',
			'common.deleteFailed' => ({required Object error}) => 'Löschen fehlgeschlagen: ${error}',
			'common.none' => 'Keine Angabe',
			'common.search' => 'Suchen',
			'common.signOut' => 'Abmelden',
			'common.clear' => 'Entfernen',
			'common.close' => 'Schließen',
			'common.copy' => 'Kopieren',
			'common.copied' => 'Kopiert',
			'tabs.close' => 'Tab schließen',
			'menu.calendar' => 'Kalender',
			'menu.contacts' => 'Kontakte',
			'menu.admin' => 'Verwaltung',
			'menu.settings' => 'Einstellungen',
			'menu.donations' => 'Spenden',
			'menu.dashboard' => 'Übersicht',
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
			'bookings.email' => 'E-Mail',
			'bookings.phone' => 'Telefon',
			'bookings.status' => 'Status',
			'bookings.statuses.inquiry' => 'Anfrage',
			'bookings.statuses.option' => 'Option',
			'bookings.statuses.confirmed' => 'Bestätigt',
			'bookings.statuses.checkedIn' => 'Angereist',
			'bookings.statuses.completed' => 'Abgeschlossen',
			'bookings.statuses.cancelled' => 'Storniert',
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
			'bookings.occupancy' => 'Belegung',
			'bookings.overview' => 'Übersicht',
			'bookings.rooms' => 'Zimmer',
			'bookings.organization' => 'Organisation',
			'bookings.mealPlan' => 'Verpflegung',
			'bookings.billingMode' => 'Rechnungen',
			'bookings.billingModes.single' => 'Eine Rechnung für die Buchung',
			'bookings.billingModes.perGroup' => 'Eine Rechnung pro Gruppe',
			'bookings.billingModes.perGuest' => 'Eine Rechnung pro Gast',
			'bookings.expectedGuests' => 'Erwartete Gäste',
			'bookings.optionExpiresAt' => 'Option gültig bis',
			'bookings.notes' => 'Notizen',
			'bookings.roomsNeedDates' => 'Bitte zuerst den Zeitraum der Buchung festlegen, um Zimmer auszuwählen.',
			'bookings.noFreeRooms' => 'In diesem Zeitraum sind keine Zimmer frei.',
			'bookings.selectedBeds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Bett ausgewählt', other: '${n} Betten ausgewählt', ), 
			'bookings.guestsExpected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Gast erwartet', other: '${n} Gäste erwartet', ), 
			'bookings.guests' => 'Gäste',
			'bookings.assignment' => 'Verteilung',
			'bookings.price' => 'Preis',
			'bookings.noGroups' => 'Noch keine Gäste. Beginnen Sie mit einer Gruppe, zum Beispiel einer Familie.',
			'bookings.addGroup' => 'Neue Gruppe',
			'bookings.editGroup' => 'Gruppe bearbeiten',
			'bookings.payer' => 'Zahlt für die Gruppe',
			'bookings.deleteGroupHint' => 'Ihre Gäste werden aus der Buchung entfernt. Die Kontakte bleiben erhalten.',
			'bookings.addGuest' => 'Gast hinzufügen',
			'bookings.editGuest' => 'Gast bearbeiten',
			'bookings.removeGuestHint' => 'Der Gast wird aus der Buchung entfernt. Der Kontakt bleibt erhalten.',
			'bookings.existingContact' => 'Vorhandener Kontakt',
			'bookings.newContact' => 'Neuer Kontakt',
			'bookings.contact' => 'Kontakt',
			'bookings.needsCrib' => 'Schläft im Kinderbett',
			'bookings.crib' => 'Kinderbett',
			'bookings.ageGroup' => 'Altersgruppe',
			'bookings.ageByBirthDate' => 'Nach Geburtsdatum',
			'bookings.ageUnknown' => 'Alter unbekannt',
			'bookings.dietaryNotes' => 'Ernährungshinweise',
			'bookings.arrivalOverride' => 'Reist später an, am',
			'bookings.departureOverride' => 'Reist früher ab, am',
			'bookings.guestCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Gast', other: '${n} Gäste', ), 
			'bookings.unassigned' => 'Ohne Zimmer',
			'bookings.everybodyAssigned' => 'Alle haben ein Zimmer.',
			'bookings.noRoomsHeld' => 'Die Buchung hat noch keine Zimmer.',
			'bookings.moveTo' => 'Verschieben nach',
			'bookings.bedsUsed' => ({required Object used, required Object beds}) => '${used} von ${beds} Betten',
			'bookings.roomFull' => 'Voll',
			'bookings.freeBeds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} freies Bett', other: '${n} freie Betten', ), 
			'bookings.roomOverfull' => 'Mehr Gäste als Betten',
			'bookings.roomNoCrib' => 'Hier kann kein Kinderbett aufgestellt werden',
			'bookings.total' => 'Gesamt',
			'bookings.inclTax' => 'Alle Preise enthalten die Steuer.',
			'bookings.nothingToPrice' => 'Noch nichts zu berechnen.',
			'bookings.wholeBooking' => 'Gesamte Buchung',
			'bookings.chargeTypes.lodging' => 'Übernachtung',
			'bookings.chargeTypes.meal' => 'Verpflegung',
			'bookings.chargeTypes.fee' => 'Gebühr',
			'bookings.chargeTypes.discount' => 'Rabatt',
			'bookings.chargeTypes.manual' => 'Sonstiges',
			'bookings.pricingProblems.datesMissing' => 'Die Buchung hat keinen Zeitraum.',
			'bookings.pricingProblems.ageUnknown' => ({required Object name}) => '${name}: Das Alter ist nicht bekannt. Bitte Geburtsdatum eintragen oder Altersgruppe wählen.',
			'bookings.pricingProblems.roomMissing' => ({required Object name}) => '${name}: hat noch kein Zimmer.',
			'bookings.pricingProblems.seasonMissing' => ({required Object date}) => 'Für den ${date} gibt es keine Saison.',
			'bookings.pricingProblems.roomRateMissing' => ({required Object detail}) => 'Kein Übernachtungspreis für ${detail}.',
			'bookings.pricingProblems.mealRateMissing' => ({required Object detail}) => 'Kein Verpflegungspreis für ${detail}.',
			'bookings.billing' => 'Abrechnung',
			'bookings.noFolios' => 'Noch nichts abzurechnen. Bitte zuerst Gäste hinzufügen und auf Zimmer verteilen.',
			'bookings.folioOpen' => 'Noch keine Rechnung',
			'bookings.folioInvoiced' => ({required Object number, required Object date}) => 'Rechnung ${number} vom ${date}',
			'bookings.stillToPay' => 'Noch zu zahlen',
			'bookings.paidInFull' => 'Vollständig bezahlt',
			'bookings.overpaid' => 'Überzahlt',
			'bookings.decide' => 'Entscheiden',
			'bookings.recordPayment' => 'Zahlung erfassen',
			'bookings.addCharge' => 'Position hinzufügen',
			'bookings.createInvoice' => 'Rechnung erstellen',
			'bookings.createInvoiceHint' => 'Die Abrechnung erhält die nächste Rechnungsnummer. Ihre Positionen können danach nicht mehr geändert werden.',
			'bookings.payment' => 'Zahlung',
			'bookings.refund' => 'Erstattung',
			'bookings.donation' => 'Spende',
			'bookings.amount' => 'Betrag',
			'bookings.date' => 'Datum',
			'bookings.paymentMethod' => 'Bezahlt per',
			'bookings.paymentMethods.cash' => 'Bar',
			'bookings.paymentMethods.bankTransfer' => 'Überweisung',
			'bookings.paymentMethods.card' => 'Karte',
			'bookings.paymentMethods.other' => 'Sonstiges',
			'bookings.reference' => 'Verwendungszweck',
			'bookings.overpaidTitle' => ({required Object amount}) => '${amount} überzahlt',
			'bookings.overpaidText' => ({required Object name}) => 'Was soll mit diesem Geld geschehen? Eine Spende bitte nur erfassen, wenn ${name} das Geld ausdrücklich als Spende überlässt.',
			'bookings.asDonation' => 'Als Spende erfassen',
			'bookings.asRefund' => 'Erstatten',
			'bookings.asCredit' => 'Als Guthaben behalten',
			'bookings.removePaymentHint' => 'Bitte nur Zahlungen entfernen, die versehentlich erfasst wurden.',
			'bookings.removeDonationHint' => 'Das Geld gilt dann wieder als überzahlt.',
			'bookings.description' => 'Beschreibung',
			'bookings.quantity' => 'Anzahl',
			'bookings.unitPrice' => 'Einzelpreis',
			'bookings.isDiscount' => 'Das ist ein Rabatt',
			'bookings.taxRate' => 'Steuersatz',
			'bookings.openInvoice' => 'Rechnung öffnen',
			'bookings.openInvoiceFailed' => ({required Object error}) => 'Die Rechnung konnte nicht geöffnet werden: ${error}',
			'bookings.renewInvoice' => 'Dokument erneuern',
			'bookings.renewInvoiceHint' => 'Die Rechnung wird mit den aktuellen Angaben, etwa der Bankverbindung, neu erstellt und ersetzt das gespeicherte Dokument. Bitte nur, solange die Rechnung noch nicht verschickt wurde.',
			'bookings.kitchen' => 'Küche',
			'bookings.guestsByAge' => 'Gäste nach Altersgruppe',
			'bookings.guestsInTotal' => 'Gäste insgesamt',
			'bookings.noMealPlan' => 'Keine gewählt',
			'bookings.noDietaryNeeds' => 'Für die Gäste sind keine Ernährungshinweise erfasst.',
			'bookings.addHousehold' => 'Haushalt hinzufügen',
			'bookings.noHouseholdsYet' => 'Es gibt noch keine Haushalte. Sie werden unter Kontakte, Haushalte angelegt.',
			'bookings.confirmation' => 'Bestätigung',
			'bookings.openConfirmationFailed' => ({required Object error}) => 'Die Bestätigung konnte nicht geöffnet werden: ${error}',
			'bookings.bedsInRooms' => ({required Object beds, required Object rooms}) => '${beds} in ${rooms}',
			'contacts.empty' => 'Keine Kontakte',
			'contacts.people' => 'Personen',
			'contacts.organizations' => 'Organisationen',
			'contacts.add' => 'Neuer Kontakt',
			'contacts.edit' => 'Kontakt bearbeiten',
			'contacts.searchHint' => 'Kontakte suchen',
			'contacts.noMatches' => 'Keine passenden Kontakte',
			'contacts.firstName' => 'Vorname',
			'contacts.lastName' => 'Nachname',
			'contacts.nameRequired' => 'Bitte Vor- oder Nachnamen angeben',
			'contacts.birthDate' => 'Geburtsdatum',
			'contacts.email' => 'E-Mail',
			'contacts.phone' => 'Telefon',
			'contacts.street' => 'Straße',
			'contacts.zip' => 'Postleitzahl',
			'contacts.city' => 'Ort',
			'contacts.country' => 'Land',
			'contacts.organization' => 'Organisation',
			'contacts.notes' => 'Notizen',
			'contacts.privacyConsent' => 'Hat der Speicherung der Daten zugestimmt',
			'contacts.noOrganizations' => 'Keine Organisationen',
			'contacts.addOrganization' => 'Neue Organisation',
			'contacts.editOrganization' => 'Organisation bearbeiten',
			'contacts.deleteOrganizationHint' => 'Ihre Kontakte bleiben erhalten, ohne Organisation.',
			'contacts.households' => 'Haushalte',
			'contacts.noHouseholds' => 'Keine Haushalte',
			'contacts.addHousehold' => 'Neuer Haushalt',
			'contacts.editHousehold' => 'Haushalt bearbeiten',
			'contacts.addMember' => 'Mitglied hinzufügen',
			'contacts.noMembers' => 'Noch keine Mitglieder',
			'contacts.deleteHouseholdHint' => 'Die Mitglieder bleiben als Kontakte erhalten.',
			'rooms.empty' => 'Keine Zimmer',
			'rooms.room' => ({required Object number}) => 'Zimmer ${number}',
			'rooms.beds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Bett', other: '${n} Betten', ), 
			'admin.sections.rooms' => 'Zimmer',
			'admin.sections.priceCategories' => 'Preiskategorien',
			'admin.sections.ageGroups' => 'Altersgruppen',
			'admin.sections.seasons' => 'Saisons',
			'admin.sections.mealPlans' => 'Verpflegung',
			'admin.sections.rates' => 'Preise',
			'admin.sections.fees' => 'Gebühren',
			'admin.sections.users' => 'Benutzer',
			'admin.sections.operator' => 'Träger',
			'admin.deleteTitle' => ({required Object name}) => '„${name}“ löschen?',
			'admin.invalidNumber' => 'Bitte eine ganze Zahl eingeben',
			'admin.invalidAmount' => 'Bitte einen Betrag wie 12,50 eingeben',
			'admin.errors.nameRequired' => 'Ein Name ist erforderlich.',
			'admin.errors.invalidDate' => 'Das Datum ist ungültig.',
			'admin.errors.invalidDateRange' => 'Das Ende darf nicht vor dem Beginn liegen.',
			'admin.errors.seasonOverlap' => ({required Object name}) => 'Der Zeitraum überschneidet sich mit der Saison „${name}“.',
			'admin.errors.invalidAgeRange' => 'Das Höchstalter darf nicht unter dem Mindestalter liegen.',
			'admin.errors.ageGroupOverlap' => ({required Object name}) => 'Die Altersangaben überschneiden sich mit der Altersgruppe „${name}“.',
			'admin.errors.invalidAmount' => 'Beträge dürfen nicht negativ sein.',
			'admin.errors.invalidTaxRate' => 'Der Steuersatz muss zwischen 0 und 100 % liegen.',
			'admin.errors.invalidBedAmount' => 'Die Bettenzahl darf nicht negativ sein.',
			'admin.errors.duplicateRate' => 'Ein Preis wurde doppelt angegeben.',
			'admin.errors.inUse' => 'Dieser Eintrag wird noch verwendet und kann nicht gelöscht werden.',
			'admin.errors.invalidGuestCount' => 'Die Gästezahl darf nicht negativ sein.',
			'admin.errors.notFound' => 'Dieser Eintrag existiert nicht mehr.',
			'admin.errors.datesRequired' => 'Eine Buchung mit Zimmern braucht einen Zeitraum.',
			'admin.errors.roomUnavailable' => ({required Object name}) => 'In diesem Zeitraum nicht frei: Zimmer ${name}.',
			'admin.errors.adminRequired' => 'Nur Admins können Daten ändern.',
			'admin.errors.ownRole' => 'Die eigene Rolle kann nicht geändert werden.',
			'admin.errors.roomNotHeld' => 'Die Buchung hat dieses Zimmer nicht.',
			'admin.errors.alreadyInvoiced' => 'Das ist bereits in Rechnung gestellt und kann nicht mehr geändert werden.',
			'admin.errors.nothingToInvoice' => 'Es gibt nichts abzurechnen.',
			'admin.errors.pricingIncomplete' => 'Teile der Buchung können noch nicht berechnet werden. Was fehlt, steht beim Preis.',
			'admin.errors.notOverpaid' => 'Das ist mehr, als überzahlt wurde.',
			'admin.errors.alreadyReceipted' => 'Diese Spende steht auf einer Bestätigung und kann nicht mehr geändert werden.',
			'admin.errors.operatorIncomplete' => 'Die Angaben zum Träger sind unvollständig. Bitte unter Verwaltung, Träger ergänzen.',
			'admin.errors.alreadyGuest' => 'Aus diesem Haushalt kann niemand hinzugefügt werden: Er hat keine Mitglieder, oder alle sind bereits Gäste der Buchung.',
			'admin.errors.notConfirmed' => 'Eine Bestätigung gibt es nur für Buchungen, die eine Option oder bestätigt sind.',
			'admin.rooms.add' => 'Neues Zimmer',
			'admin.rooms.edit' => 'Zimmer bearbeiten',
			'admin.rooms.number' => 'Zimmernummer',
			'admin.rooms.beds' => 'Betten',
			'admin.rooms.priceCategory' => 'Preiskategorie',
			'admin.rooms.noPriceCategories' => 'Bitte zuerst eine Preiskategorie anlegen.',
			'admin.rooms.building' => 'Gebäude',
			'admin.rooms.floor' => 'Etage',
			'admin.rooms.cribPossible' => 'Ein Kinderbett kann aufgestellt werden',
			'admin.rooms.crib' => 'Kinderbett möglich',
			'admin.rooms.active' => 'Aktiv',
			'admin.rooms.activeHint' => 'Inaktive Zimmer bleiben in früheren Buchungen erhalten, können aber nicht mehr gebucht werden.',
			'admin.rooms.inactive' => 'Inaktiv',
			'admin.rooms.notes' => 'Notizen',
			'admin.priceCategories.empty' => 'Keine Preiskategorien',
			'admin.priceCategories.add' => 'Neue Preiskategorie',
			'admin.priceCategories.edit' => 'Preiskategorie bearbeiten',
			'admin.priceCategories.sortOrder' => 'Position in Listen',
			'admin.priceCategories.deleteHint' => 'Die Preise dieser Kategorie werden ebenfalls gelöscht.',
			'admin.ageGroups.empty' => 'Keine Altersgruppen',
			'admin.ageGroups.add' => 'Neue Altersgruppe',
			'admin.ageGroups.edit' => 'Altersgruppe bearbeiten',
			'admin.ageGroups.minAge' => 'Ab Alter',
			'admin.ageGroups.maxAge' => 'Bis Alter',
			'admin.ageGroups.maxAgeHint' => 'Leer für keine Obergrenze',
			'admin.ageGroups.range' => ({required Object min, required Object max}) => '${min} bis ${max} Jahre',
			'admin.ageGroups.singleAge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Jahr', other: '${n} Jahre', ), 
			'admin.ageGroups.openRange' => ({required Object min}) => 'ab ${min} Jahren',
			'admin.ageGroups.deleteHint' => 'Die Preise dieser Altersgruppe werden ebenfalls gelöscht.',
			'admin.seasons.empty' => 'Keine Saisons',
			'admin.seasons.add' => 'Neue Saison',
			'admin.seasons.edit' => 'Saison bearbeiten',
			'admin.seasons.period' => 'Zeitraum',
			'admin.seasons.gap' => ({required Object from, required Object to}) => 'Für ${from} – ${to} gibt es keine Saison. Aufenthalte in diesem Zeitraum können nicht berechnet werden.',
			'admin.seasons.deleteHint' => 'Die Preise dieser Saison werden ebenfalls gelöscht.',
			'admin.mealPlans.empty' => 'Keine Verpflegungsarten',
			'admin.mealPlans.add' => 'Neue Verpflegungsart',
			'admin.mealPlans.edit' => 'Verpflegungsart bearbeiten',
			'admin.mealPlans.deleteHint' => 'Die Preise dieser Verpflegungsart werden ebenfalls gelöscht.',
			'admin.rates.lodging' => 'Übernachtung',
			'admin.rates.meals' => 'Verpflegung',
			'admin.rates.priceCategory' => 'Preiskategorie',
			'admin.rates.mealPlan' => 'Verpflegung',
			'admin.rates.missingLodging' => 'Für Preise werden mindestens eine Saison, eine Altersgruppe und eine Preiskategorie benötigt.',
			'admin.rates.missingMeals' => 'Für Preise werden mindestens eine Saison, eine Altersgruppe und eine Verpflegungsart benötigt.',
			'admin.rates.hint' => 'Preise pro Person und Nacht in Euro. Ein leeres Feld hat keinen Preis.',
			'admin.rates.invalid' => 'Bitte Beträge wie 12,50 eingeben.',
			'admin.rates.saved' => 'Preise gespeichert',
			'admin.fees.empty' => 'Keine Gebühren',
			'admin.fees.add' => 'Neue Gebühr',
			'admin.fees.edit' => 'Gebühr bearbeiten',
			'admin.fees.amount' => 'Betrag',
			'admin.fees.unit' => 'Berechnung',
			'admin.fees.units.perBooking' => 'pro Buchung',
			'admin.fees.units.perPerson' => 'pro Person',
			'admin.fees.units.perPersonNight' => 'pro Person und Nacht',
			'admin.fees.units.perRoom' => 'pro Zimmer',
			'admin.fees.units.perRoomNight' => 'pro Zimmer und Nacht',
			'admin.fees.ageGroup' => 'Gilt für',
			'admin.fees.allAges' => 'Alle Altersgruppen',
			'admin.fees.taxRate' => 'Steuersatz',
			'admin.fees.tax' => ({required Object rate}) => '${rate} % Steuer',
			'admin.fees.autoApply' => 'Zu jeder Buchung hinzufügen',
			'admin.fees.autoApplyHint' => 'Andernfalls wird die Gebühr einer Buchung von Hand hinzugefügt.',
			'admin.fees.auto' => 'jede Buchung',
			'admin.users.empty' => 'Keine Benutzer',
			'admin.users.unknownEmail' => 'Keine E-Mail-Adresse',
			'admin.users.you' => 'Sie',
			'admin.operator.hint' => 'Die Organisation, die das Haus betreibt. Diese Angaben stehen auf Rechnungen und Zuwendungsbestätigungen. Bestätigungen können erst erstellt werden, wenn alle Angaben zum Finanzamt ausgefüllt sind.',
			'admin.operator.street' => 'Straße',
			'admin.operator.zip' => 'Postleitzahl',
			'admin.operator.city' => 'Ort',
			'admin.operator.taxOffice' => 'Finanzamt',
			'admin.operator.taxNumber' => 'Steuernummer',
			'admin.operator.noticeType' => 'Bescheid des Finanzamts',
			'admin.operator.exemptionNotice' => 'Freistellungsbescheid',
			'admin.operator.statutoryCompliance' => 'Feststellungsbescheid nach § 60a AO',
			'admin.operator.noticeDate' => 'Datum des Bescheids',
			'admin.operator.assessmentPeriod' => 'Veranlagungszeitraum des Bescheids',
			'admin.operator.purposes' => 'Geförderte Zwecke, nach „zur Förderung“',
			'admin.operator.purposesHint' => 'Zum Beispiel: der Jugendhilfe',
			'admin.operator.purposesObject' => 'Geförderte Zwecke, nach „Wir fördern nach unserer Satzung“',
			'admin.operator.purposesObjectHint' => 'Zum Beispiel: die Jugendhilfe',
			'admin.operator.place' => 'Ort der Unterschrift',
			'admin.operator.signatory' => 'Unterzeichnet von',
			'admin.operator.bankHint' => 'Steht auf Rechnungen, damit klar ist, wohin und bis wann zu zahlen ist.',
			'admin.operator.accountHolder' => 'Kontoinhaber',
			'admin.operator.iban' => 'IBAN',
			'admin.operator.bic' => 'BIC',
			'admin.operator.bankName' => 'Bank',
			'admin.operator.paymentTerms' => 'Zahlungsbedingungen',
			'admin.operator.paymentTermsHint' => 'Zum Beispiel: Zahlbar innerhalb von 14 Tagen ohne Abzug.',
			'admin.operator.confirmationNote' => 'Hinweis auf Buchungsbestätigungen',
			'admin.operator.confirmationNoteHint' => 'Zum Beispiel, ab wann die Zimmer am Anreisetag bereitstehen.',
			'auth.waitingTitle' => 'Warten auf Freigabe',
			'auth.waitingText' => ({required Object email}) => 'Ihr Konto ${email} hat noch keine Rolle. Ein Admin muss den Zugriff freigeben.',
			'auth.checkAgain' => 'Erneut prüfen',
			'auth.account' => 'Konto',
			'auth.roles.admin' => 'Admin',
			'auth.roles.viewer' => 'Nur ansehen',
			'auth.roles.none' => 'Kein Zugriff',
			'donations.title' => ({required Object year}) => 'Spenden ${year}',
			'donations.empty' => ({required Object year}) => 'Keine Spenden in ${year}',
			'donations.add' => 'Neue Spende',
			'donations.donor' => 'Spender',
			'donations.amount' => 'Betrag',
			'donations.date' => 'Datum',
			'donations.fromPayment' => 'Rest einer Zahlung',
			'donations.total' => 'Gesamt',
			'donations.noReceipt' => 'Noch keine Bestätigung',
			'donations.receipts' => 'Zuwendungsbestätigungen',
			'donations.createReceipts' => 'Bestätigungen erstellen',
			'donations.previewTitle' => ({required Object year}) => 'Zuwendungsbestätigungen für ${year}',
			'donations.previewHint' => 'Jeder Spender erhält eine Bestätigung über alle Spenden des Jahres, die noch auf keiner Bestätigung stehen. Danach können diese Spenden nicht mehr geändert werden.',
			'donations.previewNone' => ({required Object year}) => 'Keine Spende aus ${year} wartet auf eine Bestätigung.',
			'donations.donationCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Spende', other: '${n} Spenden', ), 
			'donations.addressMissing' => 'Keine Bestätigung: Die Anschrift ist unvollständig',
			'donations.created' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Keine Bestätigungen erstellt', one: '${n} Bestätigung erstellt', other: '${n} Bestätigungen erstellt', ), 
			'donations.openPdf' => 'PDF öffnen',
			'donations.openFailed' => ({required Object error}) => 'Die Bestätigung konnte nicht geöffnet werden: ${error}',
			'dashboard.arrivals' => 'Anreisen in den nächsten 7 Tagen',
			'dashboard.noArrivals' => 'In den nächsten 7 Tagen reist niemand an.',
			'dashboard.departures' => 'Abreisen in den nächsten 7 Tagen',
			'dashboard.noDepartures' => 'In den nächsten 7 Tagen reist niemand ab.',
			'dashboard.tonight' => 'Heute Nacht',
			'dashboard.roomsOccupied' => ({required Object occupied, required Object total}) => '${occupied} von ${total} Zimmern belegt',
			'dashboard.guestsTonight' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Keine Gäste im Haus', one: '${n} Gast im Haus', other: '${n} Gäste im Haus', ), 
			'dashboard.roomCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Zimmer', other: '${n} Zimmer', ), 
			'dashboard.options' => 'Bald ablaufende Optionen',
			'dashboard.noOptions' => 'In den nächsten 14 Tagen läuft keine Option ab.',
			'dashboard.expires' => ({required Object date}) => 'Läuft ab am ${date}',
			'dashboard.expired' => ({required Object date}) => 'Abgelaufen am ${date}',
			'dashboard.balances' => 'Unbezahlte Rechnungen',
			'dashboard.noBalances' => 'Keine Rechnung wartet auf Zahlung.',
			'dashboard.catering' => 'Zu verpflegende Gäste',
			'dashboard.today' => 'Heute',
			'dashboard.tomorrow' => 'Morgen',
			'dashboard.noGuests' => 'Keine Gäste.',
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
			'status.loading' => 'Daten werden geladen …',
			'status.loaded' => 'Daten geladen',
			'status.saved' => 'Gespeichert',
			'status.deleted' => 'Gelöscht',
			'status.documentCreated' => ({required Object name}) => 'Dokument erstellt: ${name}',
			_ => null,
		};
	}
}
