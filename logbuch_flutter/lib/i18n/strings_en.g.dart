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
	late final Translations$admin$en admin = Translations$admin$en.internal(_root);
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$donations$en donations = Translations$donations$en.internal(_root);
	late final Translations$dashboard$en dashboard = Translations$dashboard$en.internal(_root);
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

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Discard'
	String get discard => 'Discard';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Saving failed: {error}'
	String saveFailed({required Object error}) => 'Saving failed: ${error}';

	/// en: 'Deleting failed: {error}'
	String deleteFailed({required Object error}) => 'Deleting failed: ${error}';

	/// en: 'None'
	String get none => 'None';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Sign out'
	String get signOut => 'Sign out';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Copied'
	String get copied => 'Copied';
}

// Path: tabs
class Translations$tabs$en {
	Translations$tabs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

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

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Donations'
	String get donations => 'Donations';

	/// en: 'Dashboard'
	String get dashboard => 'Dashboard';
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

	/// en: 'Occupancy'
	String get occupancy => 'Occupancy';

	/// en: 'Overview'
	String get overview => 'Overview';

	/// en: 'Rooms'
	String get rooms => 'Rooms';

	/// en: 'Organization'
	String get organization => 'Organization';

	/// en: 'Meal plan'
	String get mealPlan => 'Meal plan';

	/// en: 'Invoices'
	String get billingMode => 'Invoices';

	late final Translations$bookings$billingModes$en billingModes = Translations$bookings$billingModes$en.internal(_root);

	/// en: 'Expected guests'
	String get expectedGuests => 'Expected guests';

	/// en: 'Option valid until'
	String get optionExpiresAt => 'Option valid until';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Set the dates of the booking to choose its rooms.'
	String get roomsNeedDates => 'Set the dates of the booking to choose its rooms.';

	/// en: 'No rooms are free for these dates.'
	String get noFreeRooms => 'No rooms are free for these dates.';

	/// en: '(one) {{n} bed selected} (other) {{n} beds selected}'
	String selectedBeds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} bed selected',
		other: '${n} beds selected',
	);

	/// en: '(one) {{n} guest expected} (other) {{n} guests expected}'
	String guestsExpected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} guest expected',
		other: '${n} guests expected',
	);

	/// en: 'Guests'
	String get guests => 'Guests';

	/// en: 'Assignment'
	String get assignment => 'Assignment';

	/// en: 'Price'
	String get price => 'Price';

	/// en: 'No guests yet. Start with a group, such as a family.'
	String get noGroups => 'No guests yet. Start with a group, such as a family.';

	/// en: 'New group'
	String get addGroup => 'New group';

	/// en: 'Edit group'
	String get editGroup => 'Edit group';

	/// en: 'Pays for the group'
	String get payer => 'Pays for the group';

	/// en: 'Its guests are removed from the booking. Their contacts stay.'
	String get deleteGroupHint => 'Its guests are removed from the booking. Their contacts stay.';

	/// en: 'Add guest'
	String get addGuest => 'Add guest';

	/// en: 'Edit guest'
	String get editGuest => 'Edit guest';

	/// en: 'The guest is removed from the booking. The contact stays.'
	String get removeGuestHint => 'The guest is removed from the booking. The contact stays.';

	/// en: 'Existing contact'
	String get existingContact => 'Existing contact';

	/// en: 'New contact'
	String get newContact => 'New contact';

	/// en: 'Contact'
	String get contact => 'Contact';

	/// en: 'Sleeps in a crib'
	String get needsCrib => 'Sleeps in a crib';

	/// en: 'Crib'
	String get crib => 'Crib';

	/// en: 'Age group'
	String get ageGroup => 'Age group';

	/// en: 'By date of birth'
	String get ageByBirthDate => 'By date of birth';

	/// en: 'Age unknown'
	String get ageUnknown => 'Age unknown';

	/// en: 'Dietary needs'
	String get dietaryNotes => 'Dietary needs';

	/// en: 'Arrives later, on'
	String get arrivalOverride => 'Arrives later, on';

	/// en: 'Departs earlier, on'
	String get departureOverride => 'Departs earlier, on';

	/// en: '(one) {{n} guest} (other) {{n} guests}'
	String guestCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} guest',
		other: '${n} guests',
	);

	/// en: 'Without a room'
	String get unassigned => 'Without a room';

	/// en: 'Everybody has a room.'
	String get everybodyAssigned => 'Everybody has a room.';

	/// en: 'The booking holds no rooms yet.'
	String get noRoomsHeld => 'The booking holds no rooms yet.';

	/// en: 'Move to'
	String get moveTo => 'Move to';

	/// en: '{used} of {beds} beds'
	String bedsUsed({required Object used, required Object beds}) => '${used} of ${beds} beds';

	/// en: 'Full'
	String get roomFull => 'Full';

	/// en: '(one) {{n} free bed} (other) {{n} free beds}'
	String freeBeds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} free bed',
		other: '${n} free beds',
	);

	/// en: 'More guests than beds'
	String get roomOverfull => 'More guests than beds';

	/// en: 'No crib can be set up here'
	String get roomNoCrib => 'No crib can be set up here';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'All prices include tax.'
	String get inclTax => 'All prices include tax.';

	/// en: 'Nothing to price yet.'
	String get nothingToPrice => 'Nothing to price yet.';

	/// en: 'Whole booking'
	String get wholeBooking => 'Whole booking';

	late final Translations$bookings$chargeTypes$en chargeTypes = Translations$bookings$chargeTypes$en.internal(_root);
	late final Translations$bookings$pricingProblems$en pricingProblems = Translations$bookings$pricingProblems$en.internal(_root);

	/// en: 'Billing'
	String get billing => 'Billing';

	/// en: 'Nothing to bill yet. Add guests and give them rooms first.'
	String get noFolios => 'Nothing to bill yet. Add guests and give them rooms first.';

	/// en: 'Not invoiced yet'
	String get folioOpen => 'Not invoiced yet';

	/// en: 'Invoice {number} of {date}'
	String folioInvoiced({required Object number, required Object date}) => 'Invoice ${number} of ${date}';

	/// en: 'Still to pay'
	String get stillToPay => 'Still to pay';

	/// en: 'Paid in full'
	String get paidInFull => 'Paid in full';

	/// en: 'Overpaid'
	String get overpaid => 'Overpaid';

	/// en: 'Decide'
	String get decide => 'Decide';

	/// en: 'Record payment'
	String get recordPayment => 'Record payment';

	/// en: 'Add charge'
	String get addCharge => 'Add charge';

	/// en: 'Create invoice'
	String get createInvoice => 'Create invoice';

	/// en: 'The folio gets the next invoice number, and its charges can no longer change after that.'
	String get createInvoiceHint => 'The folio gets the next invoice number, and its charges can no longer change after that.';

	/// en: 'Payment'
	String get payment => 'Payment';

	/// en: 'Refund'
	String get refund => 'Refund';

	/// en: 'Donation'
	String get donation => 'Donation';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Paid by'
	String get paymentMethod => 'Paid by';

	late final Translations$bookings$paymentMethods$en paymentMethods = Translations$bookings$paymentMethods$en.internal(_root);

	/// en: 'Reference'
	String get reference => 'Reference';

	/// en: '{amount} overpaid'
	String overpaidTitle({required Object amount}) => '${amount} overpaid';

	/// en: 'What happens with this money? Only record a donation if {name} said to keep it as one.'
	String overpaidText({required Object name}) => 'What happens with this money? Only record a donation if ${name} said to keep it as one.';

	/// en: 'Record as donation'
	String get asDonation => 'Record as donation';

	/// en: 'Refund'
	String get asRefund => 'Refund';

	/// en: 'Keep as credit'
	String get asCredit => 'Keep as credit';

	/// en: 'Only remove a payment that was recorded by mistake.'
	String get removePaymentHint => 'Only remove a payment that was recorded by mistake.';

	/// en: 'The money counts as overpaid again.'
	String get removeDonationHint => 'The money counts as overpaid again.';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Quantity'
	String get quantity => 'Quantity';

	/// en: 'Price each'
	String get unitPrice => 'Price each';

	/// en: 'This is a discount'
	String get isDiscount => 'This is a discount';

	/// en: 'Tax rate'
	String get taxRate => 'Tax rate';

	/// en: 'Open invoice'
	String get openInvoice => 'Open invoice';

	/// en: 'The invoice could not be opened: {error}'
	String openInvoiceFailed({required Object error}) => 'The invoice could not be opened: ${error}';

	/// en: 'Renew document'
	String get renewInvoice => 'Renew document';

	/// en: 'The invoice is produced again with the details as they are now, such as the bank details, and replaces the stored document. Only do this while the invoice has not been sent.'
	String get renewInvoiceHint => 'The invoice is produced again with the details as they are now, such as the bank details, and replaces the stored document. Only do this while the invoice has not been sent.';

	/// en: 'Kitchen'
	String get kitchen => 'Kitchen';

	/// en: 'Guests by age group'
	String get guestsByAge => 'Guests by age group';

	/// en: 'Guests in total'
	String get guestsInTotal => 'Guests in total';

	/// en: 'None chosen'
	String get noMealPlan => 'None chosen';

	/// en: 'No dietary needs were noted for the guests.'
	String get noDietaryNeeds => 'No dietary needs were noted for the guests.';

	/// en: 'Add household'
	String get addHousehold => 'Add household';

	/// en: 'There are no households yet. Create them under Contacts, Households.'
	String get noHouseholdsYet => 'There are no households yet. Create them under Contacts, Households.';

	/// en: 'Confirmation'
	String get confirmation => 'Confirmation';

	/// en: 'The confirmation could not be opened: {error}'
	String openConfirmationFailed({required Object error}) => 'The confirmation could not be opened: ${error}';

	/// en: '{beds} in {rooms}'
	String bedsInRooms({required Object beds, required Object rooms}) => '${beds} in ${rooms}';
}

// Path: contacts
class Translations$contacts$en {
	Translations$contacts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No contacts'
	String get empty => 'No contacts';

	/// en: 'People'
	String get people => 'People';

	/// en: 'Organizations'
	String get organizations => 'Organizations';

	/// en: 'New contact'
	String get add => 'New contact';

	/// en: 'Edit contact'
	String get edit => 'Edit contact';

	/// en: 'Search contacts'
	String get searchHint => 'Search contacts';

	/// en: 'No matching contacts'
	String get noMatches => 'No matching contacts';

	/// en: 'First name'
	String get firstName => 'First name';

	/// en: 'Last name'
	String get lastName => 'Last name';

	/// en: 'Enter a first or a last name'
	String get nameRequired => 'Enter a first or a last name';

	/// en: 'Date of birth'
	String get birthDate => 'Date of birth';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Street'
	String get street => 'Street';

	/// en: 'Postal code'
	String get zip => 'Postal code';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'Organization'
	String get organization => 'Organization';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Consented to the storing of their data'
	String get privacyConsent => 'Consented to the storing of their data';

	/// en: 'No organizations'
	String get noOrganizations => 'No organizations';

	/// en: 'New organization'
	String get addOrganization => 'New organization';

	/// en: 'Edit organization'
	String get editOrganization => 'Edit organization';

	/// en: 'Its contacts stay, without an organization.'
	String get deleteOrganizationHint => 'Its contacts stay, without an organization.';

	/// en: 'Households'
	String get households => 'Households';

	/// en: 'No households'
	String get noHouseholds => 'No households';

	/// en: 'New household'
	String get addHousehold => 'New household';

	/// en: 'Edit household'
	String get editHousehold => 'Edit household';

	/// en: 'Add a member'
	String get addMember => 'Add a member';

	/// en: 'No members yet'
	String get noMembers => 'No members yet';

	/// en: 'Its members stay as contacts.'
	String get deleteHouseholdHint => 'Its members stay as contacts.';
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

// Path: admin
class Translations$admin$en {
	Translations$admin$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$admin$sections$en sections = Translations$admin$sections$en.internal(_root);

	/// en: 'Delete “{name}”?'
	String deleteTitle({required Object name}) => 'Delete “${name}”?';

	/// en: 'Enter a whole number'
	String get invalidNumber => 'Enter a whole number';

	/// en: 'Enter an amount such as 12.50'
	String get invalidAmount => 'Enter an amount such as 12.50';

	late final Translations$admin$errors$en errors = Translations$admin$errors$en.internal(_root);
	late final Translations$admin$rooms$en rooms = Translations$admin$rooms$en.internal(_root);
	late final Translations$admin$priceCategories$en priceCategories = Translations$admin$priceCategories$en.internal(_root);
	late final Translations$admin$ageGroups$en ageGroups = Translations$admin$ageGroups$en.internal(_root);
	late final Translations$admin$seasons$en seasons = Translations$admin$seasons$en.internal(_root);
	late final Translations$admin$mealPlans$en mealPlans = Translations$admin$mealPlans$en.internal(_root);
	late final Translations$admin$rates$en rates = Translations$admin$rates$en.internal(_root);
	late final Translations$admin$fees$en fees = Translations$admin$fees$en.internal(_root);
	late final Translations$admin$users$en users = Translations$admin$users$en.internal(_root);
	late final Translations$admin$operator$en operator = Translations$admin$operator$en.internal(_root);
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting for access'
	String get waitingTitle => 'Waiting for access';

	/// en: 'Your account {email} has no role yet. An admin has to give you access.'
	String waitingText({required Object email}) => 'Your account ${email} has no role yet. An admin has to give you access.';

	/// en: 'Check again'
	String get checkAgain => 'Check again';

	/// en: 'Account'
	String get account => 'Account';

	late final Translations$auth$roles$en roles = Translations$auth$roles$en.internal(_root);
}

// Path: donations
class Translations$donations$en {
	Translations$donations$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Donations {year}'
	String title({required Object year}) => 'Donations ${year}';

	/// en: 'No donations in {year}'
	String empty({required Object year}) => 'No donations in ${year}';

	/// en: 'New donation'
	String get add => 'New donation';

	/// en: 'Donor'
	String get donor => 'Donor';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Left over from a payment'
	String get fromPayment => 'Left over from a payment';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'No receipt yet'
	String get noReceipt => 'No receipt yet';

	/// en: 'Receipts'
	String get receipts => 'Receipts';

	/// en: 'Create receipts'
	String get createReceipts => 'Create receipts';

	/// en: 'Receipts for {year}'
	String previewTitle({required Object year}) => 'Receipts for ${year}';

	/// en: 'Every donor gets one receipt for all donations of the year that are on no receipt yet. After that these donations can no longer be changed.'
	String get previewHint => 'Every donor gets one receipt for all donations of the year that are on no receipt yet. After that these donations can no longer be changed.';

	/// en: 'No donation of {year} is waiting for a receipt.'
	String previewNone({required Object year}) => 'No donation of ${year} is waiting for a receipt.';

	/// en: '(one) {{n} donation} (other) {{n} donations}'
	String donationCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} donation',
		other: '${n} donations',
	);

	/// en: 'No receipt: the address is incomplete'
	String get addressMissing => 'No receipt: the address is incomplete';

	/// en: '(zero) {No receipts created} (one) {{n} receipt created} (other) {{n} receipts created}'
	String created({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'No receipts created',
		one: '${n} receipt created',
		other: '${n} receipts created',
	);

	/// en: 'Open the PDF'
	String get openPdf => 'Open the PDF';

	/// en: 'The receipt could not be opened: {error}'
	String openFailed({required Object error}) => 'The receipt could not be opened: ${error}';
}

// Path: dashboard
class Translations$dashboard$en {
	Translations$dashboard$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Arrivals in the next 7 days'
	String get arrivals => 'Arrivals in the next 7 days';

	/// en: 'Nobody arrives in the next 7 days.'
	String get noArrivals => 'Nobody arrives in the next 7 days.';

	/// en: 'Departures in the next 7 days'
	String get departures => 'Departures in the next 7 days';

	/// en: 'Nobody departs in the next 7 days.'
	String get noDepartures => 'Nobody departs in the next 7 days.';

	/// en: 'Tonight'
	String get tonight => 'Tonight';

	/// en: '{occupied} of {total} rooms occupied'
	String roomsOccupied({required Object occupied, required Object total}) => '${occupied} of ${total} rooms occupied';

	/// en: '(zero) {No guests in the house} (one) {{n} guest in the house} (other) {{n} guests in the house}'
	String guestsTonight({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'No guests in the house',
		one: '${n} guest in the house',
		other: '${n} guests in the house',
	);

	/// en: '(one) {{n} room} (other) {{n} rooms}'
	String roomCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} room',
		other: '${n} rooms',
	);

	/// en: 'Options expiring soon'
	String get options => 'Options expiring soon';

	/// en: 'No option expires in the next 14 days.'
	String get noOptions => 'No option expires in the next 14 days.';

	/// en: 'Expires on {date}'
	String expires({required Object date}) => 'Expires on ${date}';

	/// en: 'Expired on {date}'
	String expired({required Object date}) => 'Expired on ${date}';

	/// en: 'Unpaid invoices'
	String get balances => 'Unpaid invoices';

	/// en: 'No invoice is waiting for payment.'
	String get noBalances => 'No invoice is waiting for payment.';

	/// en: 'Guests to cater for'
	String get catering => 'Guests to cater for';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Tomorrow'
	String get tomorrow => 'Tomorrow';

	/// en: 'No guests.'
	String get noGuests => 'No guests.';
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

	/// en: 'Inquiry'
	String get inquiry => 'Inquiry';

	/// en: 'Option'
	String get option => 'Option';

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Checked in'
	String get checkedIn => 'Checked in';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';
}

// Path: bookings.billingModes
class Translations$bookings$billingModes$en {
	Translations$bookings$billingModes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'One invoice for the booking'
	String get single => 'One invoice for the booking';

	/// en: 'One invoice per group'
	String get perGroup => 'One invoice per group';

	/// en: 'One invoice per guest'
	String get perGuest => 'One invoice per guest';
}

// Path: bookings.chargeTypes
class Translations$bookings$chargeTypes$en {
	Translations$bookings$chargeTypes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lodging'
	String get lodging => 'Lodging';

	/// en: 'Meals'
	String get meal => 'Meals';

	/// en: 'Fee'
	String get fee => 'Fee';

	/// en: 'Discount'
	String get discount => 'Discount';

	/// en: 'Other'
	String get manual => 'Other';
}

// Path: bookings.pricingProblems
class Translations$bookings$pricingProblems$en {
	Translations$bookings$pricingProblems$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The booking has no dates.'
	String get datesMissing => 'The booking has no dates.';

	/// en: '{name}: the age is not known. Enter a date of birth or choose an age group.'
	String ageUnknown({required Object name}) => '${name}: the age is not known. Enter a date of birth or choose an age group.';

	/// en: '{name}: has no room yet.'
	String roomMissing({required Object name}) => '${name}: has no room yet.';

	/// en: 'No season covers {date}.'
	String seasonMissing({required Object date}) => 'No season covers ${date}.';

	/// en: 'No lodging price for {detail}.'
	String roomRateMissing({required Object detail}) => 'No lodging price for ${detail}.';

	/// en: 'No meal price for {detail}.'
	String mealRateMissing({required Object detail}) => 'No meal price for ${detail}.';
}

// Path: bookings.paymentMethods
class Translations$bookings$paymentMethods$en {
	Translations$bookings$paymentMethods$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cash'
	String get cash => 'Cash';

	/// en: 'Bank transfer'
	String get bankTransfer => 'Bank transfer';

	/// en: 'Card'
	String get card => 'Card';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: admin.sections
class Translations$admin$sections$en {
	Translations$admin$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rooms'
	String get rooms => 'Rooms';

	/// en: 'Price categories'
	String get priceCategories => 'Price categories';

	/// en: 'Age groups'
	String get ageGroups => 'Age groups';

	/// en: 'Seasons'
	String get seasons => 'Seasons';

	/// en: 'Meal plans'
	String get mealPlans => 'Meal plans';

	/// en: 'Prices'
	String get rates => 'Prices';

	/// en: 'Fees'
	String get fees => 'Fees';

	/// en: 'Users'
	String get users => 'Users';

	/// en: 'Operator'
	String get operator => 'Operator';
}

// Path: admin.errors
class Translations$admin$errors$en {
	Translations$admin$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A name is required.'
	String get nameRequired => 'A name is required.';

	/// en: 'The date is not valid.'
	String get invalidDate => 'The date is not valid.';

	/// en: 'The end must not be before the start.'
	String get invalidDateRange => 'The end must not be before the start.';

	/// en: 'The period overlaps with the season “{name}”.'
	String seasonOverlap({required Object name}) => 'The period overlaps with the season “${name}”.';

	/// en: 'The maximum age must not be below the minimum age.'
	String get invalidAgeRange => 'The maximum age must not be below the minimum age.';

	/// en: 'The ages overlap with the age group “{name}”.'
	String ageGroupOverlap({required Object name}) => 'The ages overlap with the age group “${name}”.';

	/// en: 'Amounts must not be negative.'
	String get invalidAmount => 'Amounts must not be negative.';

	/// en: 'The tax rate must be between 0 and 100 %.'
	String get invalidTaxRate => 'The tax rate must be between 0 and 100 %.';

	/// en: 'The number of beds must not be negative.'
	String get invalidBedAmount => 'The number of beds must not be negative.';

	/// en: 'A price was entered twice.'
	String get duplicateRate => 'A price was entered twice.';

	/// en: 'This entry is still in use and cannot be deleted.'
	String get inUse => 'This entry is still in use and cannot be deleted.';

	/// en: 'The number of guests must not be negative.'
	String get invalidGuestCount => 'The number of guests must not be negative.';

	/// en: 'This entry no longer exists.'
	String get notFound => 'This entry no longer exists.';

	/// en: 'A booking that holds rooms needs dates.'
	String get datesRequired => 'A booking that holds rooms needs dates.';

	/// en: 'Not free for these dates: room {name}.'
	String roomUnavailable({required Object name}) => 'Not free for these dates: room ${name}.';

	/// en: 'Only admins can change data.'
	String get adminRequired => 'Only admins can change data.';

	/// en: 'You cannot change your own role.'
	String get ownRole => 'You cannot change your own role.';

	/// en: 'The booking does not hold this room.'
	String get roomNotHeld => 'The booking does not hold this room.';

	/// en: 'This is invoiced and can no longer be changed.'
	String get alreadyInvoiced => 'This is invoiced and can no longer be changed.';

	/// en: 'There is nothing to invoice.'
	String get nothingToInvoice => 'There is nothing to invoice.';

	/// en: 'Parts of the booking cannot be priced yet. Its price says what is missing.'
	String get pricingIncomplete => 'Parts of the booking cannot be priced yet. Its price says what is missing.';

	/// en: 'This is more than was overpaid.'
	String get notOverpaid => 'This is more than was overpaid.';

	/// en: 'This donation is on a receipt and can no longer be changed.'
	String get alreadyReceipted => 'This donation is on a receipt and can no longer be changed.';

	/// en: 'The details of the operator are incomplete. Fill them in under Admin, Operator.'
	String get operatorIncomplete => 'The details of the operator are incomplete. Fill them in under Admin, Operator.';

	/// en: 'Nobody in this household can be added: it has no members, or all of them are guests of the booking already.'
	String get alreadyGuest => 'Nobody in this household can be added: it has no members, or all of them are guests of the booking already.';

	/// en: 'A confirmation is only available for a booking that is an option or confirmed.'
	String get notConfirmed => 'A confirmation is only available for a booking that is an option or confirmed.';
}

// Path: admin.rooms
class Translations$admin$rooms$en {
	Translations$admin$rooms$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New room'
	String get add => 'New room';

	/// en: 'Edit room'
	String get edit => 'Edit room';

	/// en: 'Room number'
	String get number => 'Room number';

	/// en: 'Beds'
	String get beds => 'Beds';

	/// en: 'Price category'
	String get priceCategory => 'Price category';

	/// en: 'Create a price category first.'
	String get noPriceCategories => 'Create a price category first.';

	/// en: 'Building'
	String get building => 'Building';

	/// en: 'Floor'
	String get floor => 'Floor';

	/// en: 'A crib can be set up'
	String get cribPossible => 'A crib can be set up';

	/// en: 'Crib possible'
	String get crib => 'Crib possible';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive rooms stay in past bookings but can no longer be booked.'
	String get activeHint => 'Inactive rooms stay in past bookings but can no longer be booked.';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Notes'
	String get notes => 'Notes';
}

// Path: admin.priceCategories
class Translations$admin$priceCategories$en {
	Translations$admin$priceCategories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No price categories'
	String get empty => 'No price categories';

	/// en: 'New price category'
	String get add => 'New price category';

	/// en: 'Edit price category'
	String get edit => 'Edit price category';

	/// en: 'Position in lists'
	String get sortOrder => 'Position in lists';

	/// en: 'The prices of this category are deleted as well.'
	String get deleteHint => 'The prices of this category are deleted as well.';
}

// Path: admin.ageGroups
class Translations$admin$ageGroups$en {
	Translations$admin$ageGroups$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No age groups'
	String get empty => 'No age groups';

	/// en: 'New age group'
	String get add => 'New age group';

	/// en: 'Edit age group'
	String get edit => 'Edit age group';

	/// en: 'From age'
	String get minAge => 'From age';

	/// en: 'To age'
	String get maxAge => 'To age';

	/// en: 'Empty for no upper limit'
	String get maxAgeHint => 'Empty for no upper limit';

	/// en: '{min} to {max} years'
	String range({required Object min, required Object max}) => '${min} to ${max} years';

	/// en: '(one) {{n} year} (other) {{n} years}'
	String singleAge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} year',
		other: '${n} years',
	);

	/// en: '{min} years and older'
	String openRange({required Object min}) => '${min} years and older';

	/// en: 'The prices of this age group are deleted as well.'
	String get deleteHint => 'The prices of this age group are deleted as well.';
}

// Path: admin.seasons
class Translations$admin$seasons$en {
	Translations$admin$seasons$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No seasons'
	String get empty => 'No seasons';

	/// en: 'New season'
	String get add => 'New season';

	/// en: 'Edit season'
	String get edit => 'Edit season';

	/// en: 'Period'
	String get period => 'Period';

	/// en: 'No season covers {from} – {to}. Stays in this period cannot be priced.'
	String gap({required Object from, required Object to}) => 'No season covers ${from} – ${to}. Stays in this period cannot be priced.';

	/// en: 'The prices of this season are deleted as well.'
	String get deleteHint => 'The prices of this season are deleted as well.';
}

// Path: admin.mealPlans
class Translations$admin$mealPlans$en {
	Translations$admin$mealPlans$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No meal plans'
	String get empty => 'No meal plans';

	/// en: 'New meal plan'
	String get add => 'New meal plan';

	/// en: 'Edit meal plan'
	String get edit => 'Edit meal plan';

	/// en: 'The prices of this meal plan are deleted as well.'
	String get deleteHint => 'The prices of this meal plan are deleted as well.';
}

// Path: admin.rates
class Translations$admin$rates$en {
	Translations$admin$rates$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lodging'
	String get lodging => 'Lodging';

	/// en: 'Meals'
	String get meals => 'Meals';

	/// en: 'Price category'
	String get priceCategory => 'Price category';

	/// en: 'Meal plan'
	String get mealPlan => 'Meal plan';

	/// en: 'Prices need at least one season, one age group and one price category.'
	String get missingLodging => 'Prices need at least one season, one age group and one price category.';

	/// en: 'Prices need at least one season, one age group and one meal plan.'
	String get missingMeals => 'Prices need at least one season, one age group and one meal plan.';

	/// en: 'Prices per person and night in euros. An empty field has no price.'
	String get hint => 'Prices per person and night in euros. An empty field has no price.';

	/// en: 'Enter amounts such as 12.50.'
	String get invalid => 'Enter amounts such as 12.50.';

	/// en: 'Prices saved'
	String get saved => 'Prices saved';
}

// Path: admin.fees
class Translations$admin$fees$en {
	Translations$admin$fees$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No fees'
	String get empty => 'No fees';

	/// en: 'New fee'
	String get add => 'New fee';

	/// en: 'Edit fee'
	String get edit => 'Edit fee';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Charged'
	String get unit => 'Charged';

	late final Translations$admin$fees$units$en units = Translations$admin$fees$units$en.internal(_root);

	/// en: 'Applies to'
	String get ageGroup => 'Applies to';

	/// en: 'All ages'
	String get allAges => 'All ages';

	/// en: 'Tax rate'
	String get taxRate => 'Tax rate';

	/// en: '{rate} % tax'
	String tax({required Object rate}) => '${rate} % tax';

	/// en: 'Add to every booking'
	String get autoApply => 'Add to every booking';

	/// en: 'Otherwise the fee is added to a booking by hand.'
	String get autoApplyHint => 'Otherwise the fee is added to a booking by hand.';

	/// en: 'every booking'
	String get auto => 'every booking';
}

// Path: admin.users
class Translations$admin$users$en {
	Translations$admin$users$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No users'
	String get empty => 'No users';

	/// en: 'No email address'
	String get unknownEmail => 'No email address';

	/// en: 'you'
	String get you => 'you';
}

// Path: admin.operator
class Translations$admin$operator$en {
	Translations$admin$operator$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The organisation that runs the house. These details are printed on invoices and donation receipts. Receipts can only be issued once everything about the tax office is filled in.'
	String get hint => 'The organisation that runs the house. These details are printed on invoices and donation receipts. Receipts can only be issued once everything about the tax office is filled in.';

	/// en: 'Street'
	String get street => 'Street';

	/// en: 'Postal code'
	String get zip => 'Postal code';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Tax office'
	String get taxOffice => 'Tax office';

	/// en: 'Tax number'
	String get taxNumber => 'Tax number';

	/// en: 'Notice of the tax office'
	String get noticeType => 'Notice of the tax office';

	/// en: 'Freistellungsbescheid'
	String get exemptionNotice => 'Freistellungsbescheid';

	/// en: 'Feststellungsbescheid nach § 60a AO'
	String get statutoryCompliance => 'Feststellungsbescheid nach § 60a AO';

	/// en: 'Date of the notice'
	String get noticeDate => 'Date of the notice';

	/// en: 'Assessment period of the notice'
	String get assessmentPeriod => 'Assessment period of the notice';

	/// en: 'Promoted purposes, following “zur Förderung”'
	String get purposes => 'Promoted purposes, following “zur Förderung”';

	/// en: 'In German, for example: der Jugendhilfe'
	String get purposesHint => 'In German, for example: der Jugendhilfe';

	/// en: 'Promoted purposes, following “Wir fördern nach unserer Satzung”'
	String get purposesObject => 'Promoted purposes, following “Wir fördern nach unserer Satzung”';

	/// en: 'In German, for example: die Jugendhilfe'
	String get purposesObjectHint => 'In German, for example: die Jugendhilfe';

	/// en: 'Place where receipts are signed'
	String get place => 'Place where receipts are signed';

	/// en: 'Signed by'
	String get signatory => 'Signed by';

	/// en: 'Saved'
	String get saved => 'Saved';

	/// en: 'Printed on invoices, so that payers know where and by when to pay.'
	String get bankHint => 'Printed on invoices, so that payers know where and by when to pay.';

	/// en: 'Account holder'
	String get accountHolder => 'Account holder';

	/// en: 'IBAN'
	String get iban => 'IBAN';

	/// en: 'BIC'
	String get bic => 'BIC';

	/// en: 'Bank'
	String get bankName => 'Bank';

	/// en: 'Payment terms'
	String get paymentTerms => 'Payment terms';

	/// en: 'In German, for example: Zahlbar innerhalb von 14 Tagen ohne Abzug.'
	String get paymentTermsHint => 'In German, for example: Zahlbar innerhalb von 14 Tagen ohne Abzug.';

	/// en: 'Note on booking confirmations'
	String get confirmationNote => 'Note on booking confirmations';

	/// en: 'In German, for example when rooms are ready on the day of arrival.'
	String get confirmationNoteHint => 'In German, for example when rooms are ready on the day of arrival.';
}

// Path: auth.roles
class Translations$auth$roles$en {
	Translations$auth$roles$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'View only'
	String get viewer => 'View only';

	/// en: 'No access'
	String get none => 'No access';
}

// Path: admin.fees.units
class Translations$admin$fees$units$en {
	Translations$admin$fees$units$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'per booking'
	String get perBooking => 'per booking';

	/// en: 'per person'
	String get perPerson => 'per person';

	/// en: 'per person and night'
	String get perPersonNight => 'per person and night';

	/// en: 'per room'
	String get perRoom => 'per room';

	/// en: 'per room and night'
	String get perRoomNight => 'per room and night';
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
			'common.edit' => 'Edit',
			'common.delete' => 'Delete',
			'common.cancel' => 'Cancel',
			'common.save' => 'Save',
			'common.discard' => 'Discard',
			'common.required' => 'Required',
			'common.name' => 'Name',
			'common.saveFailed' => ({required Object error}) => 'Saving failed: ${error}',
			'common.deleteFailed' => ({required Object error}) => 'Deleting failed: ${error}',
			'common.none' => 'None',
			'common.search' => 'Search',
			'common.signOut' => 'Sign out',
			'common.clear' => 'Clear',
			'common.close' => 'Close',
			'common.copy' => 'Copy',
			'common.copied' => 'Copied',
			'tabs.close' => 'Close tab',
			'menu.calendar' => 'Calendar',
			'menu.contacts' => 'Contacts',
			'menu.admin' => 'Admin',
			'menu.settings' => 'Settings',
			'menu.donations' => 'Donations',
			'menu.dashboard' => 'Dashboard',
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
			'bookings.email' => 'Email',
			'bookings.phone' => 'Phone',
			'bookings.status' => 'Status',
			'bookings.statuses.inquiry' => 'Inquiry',
			'bookings.statuses.option' => 'Option',
			'bookings.statuses.confirmed' => 'Confirmed',
			'bookings.statuses.checkedIn' => 'Checked in',
			'bookings.statuses.completed' => 'Completed',
			'bookings.statuses.cancelled' => 'Cancelled',
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
			'bookings.occupancy' => 'Occupancy',
			'bookings.overview' => 'Overview',
			'bookings.rooms' => 'Rooms',
			'bookings.organization' => 'Organization',
			'bookings.mealPlan' => 'Meal plan',
			'bookings.billingMode' => 'Invoices',
			'bookings.billingModes.single' => 'One invoice for the booking',
			'bookings.billingModes.perGroup' => 'One invoice per group',
			'bookings.billingModes.perGuest' => 'One invoice per guest',
			'bookings.expectedGuests' => 'Expected guests',
			'bookings.optionExpiresAt' => 'Option valid until',
			'bookings.notes' => 'Notes',
			'bookings.roomsNeedDates' => 'Set the dates of the booking to choose its rooms.',
			'bookings.noFreeRooms' => 'No rooms are free for these dates.',
			'bookings.selectedBeds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} bed selected', other: '${n} beds selected', ), 
			'bookings.guestsExpected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} guest expected', other: '${n} guests expected', ), 
			'bookings.guests' => 'Guests',
			'bookings.assignment' => 'Assignment',
			'bookings.price' => 'Price',
			'bookings.noGroups' => 'No guests yet. Start with a group, such as a family.',
			'bookings.addGroup' => 'New group',
			'bookings.editGroup' => 'Edit group',
			'bookings.payer' => 'Pays for the group',
			'bookings.deleteGroupHint' => 'Its guests are removed from the booking. Their contacts stay.',
			'bookings.addGuest' => 'Add guest',
			'bookings.editGuest' => 'Edit guest',
			'bookings.removeGuestHint' => 'The guest is removed from the booking. The contact stays.',
			'bookings.existingContact' => 'Existing contact',
			'bookings.newContact' => 'New contact',
			'bookings.contact' => 'Contact',
			'bookings.needsCrib' => 'Sleeps in a crib',
			'bookings.crib' => 'Crib',
			'bookings.ageGroup' => 'Age group',
			'bookings.ageByBirthDate' => 'By date of birth',
			'bookings.ageUnknown' => 'Age unknown',
			'bookings.dietaryNotes' => 'Dietary needs',
			'bookings.arrivalOverride' => 'Arrives later, on',
			'bookings.departureOverride' => 'Departs earlier, on',
			'bookings.guestCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} guest', other: '${n} guests', ), 
			'bookings.unassigned' => 'Without a room',
			'bookings.everybodyAssigned' => 'Everybody has a room.',
			'bookings.noRoomsHeld' => 'The booking holds no rooms yet.',
			'bookings.moveTo' => 'Move to',
			'bookings.bedsUsed' => ({required Object used, required Object beds}) => '${used} of ${beds} beds',
			'bookings.roomFull' => 'Full',
			'bookings.freeBeds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} free bed', other: '${n} free beds', ), 
			'bookings.roomOverfull' => 'More guests than beds',
			'bookings.roomNoCrib' => 'No crib can be set up here',
			'bookings.total' => 'Total',
			'bookings.inclTax' => 'All prices include tax.',
			'bookings.nothingToPrice' => 'Nothing to price yet.',
			'bookings.wholeBooking' => 'Whole booking',
			'bookings.chargeTypes.lodging' => 'Lodging',
			'bookings.chargeTypes.meal' => 'Meals',
			'bookings.chargeTypes.fee' => 'Fee',
			'bookings.chargeTypes.discount' => 'Discount',
			'bookings.chargeTypes.manual' => 'Other',
			'bookings.pricingProblems.datesMissing' => 'The booking has no dates.',
			'bookings.pricingProblems.ageUnknown' => ({required Object name}) => '${name}: the age is not known. Enter a date of birth or choose an age group.',
			'bookings.pricingProblems.roomMissing' => ({required Object name}) => '${name}: has no room yet.',
			'bookings.pricingProblems.seasonMissing' => ({required Object date}) => 'No season covers ${date}.',
			'bookings.pricingProblems.roomRateMissing' => ({required Object detail}) => 'No lodging price for ${detail}.',
			'bookings.pricingProblems.mealRateMissing' => ({required Object detail}) => 'No meal price for ${detail}.',
			'bookings.billing' => 'Billing',
			'bookings.noFolios' => 'Nothing to bill yet. Add guests and give them rooms first.',
			'bookings.folioOpen' => 'Not invoiced yet',
			'bookings.folioInvoiced' => ({required Object number, required Object date}) => 'Invoice ${number} of ${date}',
			'bookings.stillToPay' => 'Still to pay',
			'bookings.paidInFull' => 'Paid in full',
			'bookings.overpaid' => 'Overpaid',
			'bookings.decide' => 'Decide',
			'bookings.recordPayment' => 'Record payment',
			'bookings.addCharge' => 'Add charge',
			'bookings.createInvoice' => 'Create invoice',
			'bookings.createInvoiceHint' => 'The folio gets the next invoice number, and its charges can no longer change after that.',
			'bookings.payment' => 'Payment',
			'bookings.refund' => 'Refund',
			'bookings.donation' => 'Donation',
			'bookings.amount' => 'Amount',
			'bookings.date' => 'Date',
			'bookings.paymentMethod' => 'Paid by',
			'bookings.paymentMethods.cash' => 'Cash',
			'bookings.paymentMethods.bankTransfer' => 'Bank transfer',
			'bookings.paymentMethods.card' => 'Card',
			'bookings.paymentMethods.other' => 'Other',
			'bookings.reference' => 'Reference',
			'bookings.overpaidTitle' => ({required Object amount}) => '${amount} overpaid',
			'bookings.overpaidText' => ({required Object name}) => 'What happens with this money? Only record a donation if ${name} said to keep it as one.',
			'bookings.asDonation' => 'Record as donation',
			'bookings.asRefund' => 'Refund',
			'bookings.asCredit' => 'Keep as credit',
			'bookings.removePaymentHint' => 'Only remove a payment that was recorded by mistake.',
			'bookings.removeDonationHint' => 'The money counts as overpaid again.',
			'bookings.description' => 'Description',
			'bookings.quantity' => 'Quantity',
			'bookings.unitPrice' => 'Price each',
			'bookings.isDiscount' => 'This is a discount',
			'bookings.taxRate' => 'Tax rate',
			'bookings.openInvoice' => 'Open invoice',
			'bookings.openInvoiceFailed' => ({required Object error}) => 'The invoice could not be opened: ${error}',
			'bookings.renewInvoice' => 'Renew document',
			'bookings.renewInvoiceHint' => 'The invoice is produced again with the details as they are now, such as the bank details, and replaces the stored document. Only do this while the invoice has not been sent.',
			'bookings.kitchen' => 'Kitchen',
			'bookings.guestsByAge' => 'Guests by age group',
			'bookings.guestsInTotal' => 'Guests in total',
			'bookings.noMealPlan' => 'None chosen',
			'bookings.noDietaryNeeds' => 'No dietary needs were noted for the guests.',
			'bookings.addHousehold' => 'Add household',
			'bookings.noHouseholdsYet' => 'There are no households yet. Create them under Contacts, Households.',
			'bookings.confirmation' => 'Confirmation',
			'bookings.openConfirmationFailed' => ({required Object error}) => 'The confirmation could not be opened: ${error}',
			'bookings.bedsInRooms' => ({required Object beds, required Object rooms}) => '${beds} in ${rooms}',
			'contacts.empty' => 'No contacts',
			'contacts.people' => 'People',
			'contacts.organizations' => 'Organizations',
			'contacts.add' => 'New contact',
			'contacts.edit' => 'Edit contact',
			'contacts.searchHint' => 'Search contacts',
			'contacts.noMatches' => 'No matching contacts',
			'contacts.firstName' => 'First name',
			'contacts.lastName' => 'Last name',
			'contacts.nameRequired' => 'Enter a first or a last name',
			'contacts.birthDate' => 'Date of birth',
			'contacts.email' => 'Email',
			'contacts.phone' => 'Phone',
			'contacts.street' => 'Street',
			'contacts.zip' => 'Postal code',
			'contacts.city' => 'City',
			'contacts.country' => 'Country',
			'contacts.organization' => 'Organization',
			'contacts.notes' => 'Notes',
			'contacts.privacyConsent' => 'Consented to the storing of their data',
			'contacts.noOrganizations' => 'No organizations',
			'contacts.addOrganization' => 'New organization',
			'contacts.editOrganization' => 'Edit organization',
			'contacts.deleteOrganizationHint' => 'Its contacts stay, without an organization.',
			'contacts.households' => 'Households',
			'contacts.noHouseholds' => 'No households',
			'contacts.addHousehold' => 'New household',
			'contacts.editHousehold' => 'Edit household',
			'contacts.addMember' => 'Add a member',
			'contacts.noMembers' => 'No members yet',
			'contacts.deleteHouseholdHint' => 'Its members stay as contacts.',
			'rooms.empty' => 'No rooms',
			'rooms.room' => ({required Object number}) => 'Room ${number}',
			'rooms.beds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} bed', other: '${n} beds', ), 
			'admin.sections.rooms' => 'Rooms',
			'admin.sections.priceCategories' => 'Price categories',
			'admin.sections.ageGroups' => 'Age groups',
			'admin.sections.seasons' => 'Seasons',
			'admin.sections.mealPlans' => 'Meal plans',
			'admin.sections.rates' => 'Prices',
			'admin.sections.fees' => 'Fees',
			'admin.sections.users' => 'Users',
			'admin.sections.operator' => 'Operator',
			'admin.deleteTitle' => ({required Object name}) => 'Delete “${name}”?',
			'admin.invalidNumber' => 'Enter a whole number',
			'admin.invalidAmount' => 'Enter an amount such as 12.50',
			'admin.errors.nameRequired' => 'A name is required.',
			'admin.errors.invalidDate' => 'The date is not valid.',
			'admin.errors.invalidDateRange' => 'The end must not be before the start.',
			'admin.errors.seasonOverlap' => ({required Object name}) => 'The period overlaps with the season “${name}”.',
			'admin.errors.invalidAgeRange' => 'The maximum age must not be below the minimum age.',
			'admin.errors.ageGroupOverlap' => ({required Object name}) => 'The ages overlap with the age group “${name}”.',
			'admin.errors.invalidAmount' => 'Amounts must not be negative.',
			'admin.errors.invalidTaxRate' => 'The tax rate must be between 0 and 100 %.',
			'admin.errors.invalidBedAmount' => 'The number of beds must not be negative.',
			'admin.errors.duplicateRate' => 'A price was entered twice.',
			'admin.errors.inUse' => 'This entry is still in use and cannot be deleted.',
			'admin.errors.invalidGuestCount' => 'The number of guests must not be negative.',
			'admin.errors.notFound' => 'This entry no longer exists.',
			'admin.errors.datesRequired' => 'A booking that holds rooms needs dates.',
			'admin.errors.roomUnavailable' => ({required Object name}) => 'Not free for these dates: room ${name}.',
			'admin.errors.adminRequired' => 'Only admins can change data.',
			'admin.errors.ownRole' => 'You cannot change your own role.',
			'admin.errors.roomNotHeld' => 'The booking does not hold this room.',
			'admin.errors.alreadyInvoiced' => 'This is invoiced and can no longer be changed.',
			'admin.errors.nothingToInvoice' => 'There is nothing to invoice.',
			'admin.errors.pricingIncomplete' => 'Parts of the booking cannot be priced yet. Its price says what is missing.',
			'admin.errors.notOverpaid' => 'This is more than was overpaid.',
			'admin.errors.alreadyReceipted' => 'This donation is on a receipt and can no longer be changed.',
			'admin.errors.operatorIncomplete' => 'The details of the operator are incomplete. Fill them in under Admin, Operator.',
			'admin.errors.alreadyGuest' => 'Nobody in this household can be added: it has no members, or all of them are guests of the booking already.',
			'admin.errors.notConfirmed' => 'A confirmation is only available for a booking that is an option or confirmed.',
			'admin.rooms.add' => 'New room',
			'admin.rooms.edit' => 'Edit room',
			'admin.rooms.number' => 'Room number',
			'admin.rooms.beds' => 'Beds',
			'admin.rooms.priceCategory' => 'Price category',
			'admin.rooms.noPriceCategories' => 'Create a price category first.',
			'admin.rooms.building' => 'Building',
			'admin.rooms.floor' => 'Floor',
			'admin.rooms.cribPossible' => 'A crib can be set up',
			'admin.rooms.crib' => 'Crib possible',
			'admin.rooms.active' => 'Active',
			'admin.rooms.activeHint' => 'Inactive rooms stay in past bookings but can no longer be booked.',
			'admin.rooms.inactive' => 'Inactive',
			'admin.rooms.notes' => 'Notes',
			'admin.priceCategories.empty' => 'No price categories',
			'admin.priceCategories.add' => 'New price category',
			'admin.priceCategories.edit' => 'Edit price category',
			'admin.priceCategories.sortOrder' => 'Position in lists',
			'admin.priceCategories.deleteHint' => 'The prices of this category are deleted as well.',
			'admin.ageGroups.empty' => 'No age groups',
			'admin.ageGroups.add' => 'New age group',
			'admin.ageGroups.edit' => 'Edit age group',
			'admin.ageGroups.minAge' => 'From age',
			'admin.ageGroups.maxAge' => 'To age',
			'admin.ageGroups.maxAgeHint' => 'Empty for no upper limit',
			'admin.ageGroups.range' => ({required Object min, required Object max}) => '${min} to ${max} years',
			'admin.ageGroups.singleAge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} year', other: '${n} years', ), 
			'admin.ageGroups.openRange' => ({required Object min}) => '${min} years and older',
			'admin.ageGroups.deleteHint' => 'The prices of this age group are deleted as well.',
			'admin.seasons.empty' => 'No seasons',
			'admin.seasons.add' => 'New season',
			'admin.seasons.edit' => 'Edit season',
			'admin.seasons.period' => 'Period',
			'admin.seasons.gap' => ({required Object from, required Object to}) => 'No season covers ${from} – ${to}. Stays in this period cannot be priced.',
			'admin.seasons.deleteHint' => 'The prices of this season are deleted as well.',
			'admin.mealPlans.empty' => 'No meal plans',
			'admin.mealPlans.add' => 'New meal plan',
			'admin.mealPlans.edit' => 'Edit meal plan',
			'admin.mealPlans.deleteHint' => 'The prices of this meal plan are deleted as well.',
			'admin.rates.lodging' => 'Lodging',
			'admin.rates.meals' => 'Meals',
			'admin.rates.priceCategory' => 'Price category',
			'admin.rates.mealPlan' => 'Meal plan',
			'admin.rates.missingLodging' => 'Prices need at least one season, one age group and one price category.',
			'admin.rates.missingMeals' => 'Prices need at least one season, one age group and one meal plan.',
			'admin.rates.hint' => 'Prices per person and night in euros. An empty field has no price.',
			'admin.rates.invalid' => 'Enter amounts such as 12.50.',
			'admin.rates.saved' => 'Prices saved',
			'admin.fees.empty' => 'No fees',
			'admin.fees.add' => 'New fee',
			'admin.fees.edit' => 'Edit fee',
			'admin.fees.amount' => 'Amount',
			'admin.fees.unit' => 'Charged',
			'admin.fees.units.perBooking' => 'per booking',
			'admin.fees.units.perPerson' => 'per person',
			'admin.fees.units.perPersonNight' => 'per person and night',
			'admin.fees.units.perRoom' => 'per room',
			'admin.fees.units.perRoomNight' => 'per room and night',
			'admin.fees.ageGroup' => 'Applies to',
			'admin.fees.allAges' => 'All ages',
			'admin.fees.taxRate' => 'Tax rate',
			'admin.fees.tax' => ({required Object rate}) => '${rate} % tax',
			'admin.fees.autoApply' => 'Add to every booking',
			'admin.fees.autoApplyHint' => 'Otherwise the fee is added to a booking by hand.',
			'admin.fees.auto' => 'every booking',
			'admin.users.empty' => 'No users',
			'admin.users.unknownEmail' => 'No email address',
			'admin.users.you' => 'you',
			'admin.operator.hint' => 'The organisation that runs the house. These details are printed on invoices and donation receipts. Receipts can only be issued once everything about the tax office is filled in.',
			'admin.operator.street' => 'Street',
			'admin.operator.zip' => 'Postal code',
			'admin.operator.city' => 'City',
			'admin.operator.taxOffice' => 'Tax office',
			'admin.operator.taxNumber' => 'Tax number',
			'admin.operator.noticeType' => 'Notice of the tax office',
			'admin.operator.exemptionNotice' => 'Freistellungsbescheid',
			'admin.operator.statutoryCompliance' => 'Feststellungsbescheid nach § 60a AO',
			'admin.operator.noticeDate' => 'Date of the notice',
			'admin.operator.assessmentPeriod' => 'Assessment period of the notice',
			'admin.operator.purposes' => 'Promoted purposes, following “zur Förderung”',
			'admin.operator.purposesHint' => 'In German, for example: der Jugendhilfe',
			'admin.operator.purposesObject' => 'Promoted purposes, following “Wir fördern nach unserer Satzung”',
			'admin.operator.purposesObjectHint' => 'In German, for example: die Jugendhilfe',
			'admin.operator.place' => 'Place where receipts are signed',
			'admin.operator.signatory' => 'Signed by',
			'admin.operator.saved' => 'Saved',
			'admin.operator.bankHint' => 'Printed on invoices, so that payers know where and by when to pay.',
			'admin.operator.accountHolder' => 'Account holder',
			'admin.operator.iban' => 'IBAN',
			'admin.operator.bic' => 'BIC',
			'admin.operator.bankName' => 'Bank',
			'admin.operator.paymentTerms' => 'Payment terms',
			'admin.operator.paymentTermsHint' => 'In German, for example: Zahlbar innerhalb von 14 Tagen ohne Abzug.',
			'admin.operator.confirmationNote' => 'Note on booking confirmations',
			'admin.operator.confirmationNoteHint' => 'In German, for example when rooms are ready on the day of arrival.',
			'auth.waitingTitle' => 'Waiting for access',
			'auth.waitingText' => ({required Object email}) => 'Your account ${email} has no role yet. An admin has to give you access.',
			'auth.checkAgain' => 'Check again',
			'auth.account' => 'Account',
			'auth.roles.admin' => 'Admin',
			'auth.roles.viewer' => 'View only',
			'auth.roles.none' => 'No access',
			'donations.title' => ({required Object year}) => 'Donations ${year}',
			'donations.empty' => ({required Object year}) => 'No donations in ${year}',
			'donations.add' => 'New donation',
			'donations.donor' => 'Donor',
			'donations.amount' => 'Amount',
			'donations.date' => 'Date',
			'donations.fromPayment' => 'Left over from a payment',
			'donations.total' => 'Total',
			'donations.noReceipt' => 'No receipt yet',
			'donations.receipts' => 'Receipts',
			'donations.createReceipts' => 'Create receipts',
			'donations.previewTitle' => ({required Object year}) => 'Receipts for ${year}',
			'donations.previewHint' => 'Every donor gets one receipt for all donations of the year that are on no receipt yet. After that these donations can no longer be changed.',
			'donations.previewNone' => ({required Object year}) => 'No donation of ${year} is waiting for a receipt.',
			'donations.donationCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} donation', other: '${n} donations', ), 
			'donations.addressMissing' => 'No receipt: the address is incomplete',
			'donations.created' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'No receipts created', one: '${n} receipt created', other: '${n} receipts created', ), 
			'donations.openPdf' => 'Open the PDF',
			'donations.openFailed' => ({required Object error}) => 'The receipt could not be opened: ${error}',
			'dashboard.arrivals' => 'Arrivals in the next 7 days',
			'dashboard.noArrivals' => 'Nobody arrives in the next 7 days.',
			'dashboard.departures' => 'Departures in the next 7 days',
			'dashboard.noDepartures' => 'Nobody departs in the next 7 days.',
			'dashboard.tonight' => 'Tonight',
			'dashboard.roomsOccupied' => ({required Object occupied, required Object total}) => '${occupied} of ${total} rooms occupied',
			'dashboard.guestsTonight' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'No guests in the house', one: '${n} guest in the house', other: '${n} guests in the house', ), 
			'dashboard.roomCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} room', other: '${n} rooms', ), 
			'dashboard.options' => 'Options expiring soon',
			'dashboard.noOptions' => 'No option expires in the next 14 days.',
			'dashboard.expires' => ({required Object date}) => 'Expires on ${date}',
			'dashboard.expired' => ({required Object date}) => 'Expired on ${date}',
			'dashboard.balances' => 'Unpaid invoices',
			'dashboard.noBalances' => 'No invoice is waiting for payment.',
			'dashboard.catering' => 'Guests to cater for',
			'dashboard.today' => 'Today',
			'dashboard.tomorrow' => 'Tomorrow',
			'dashboard.noGuests' => 'No guests.',
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
