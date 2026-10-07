import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/admin/booking_categories_section.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/providers/booking_categories_provider.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/meal_plans_provider.dart';
import 'package:logbuch_flutter/providers/organizations_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// Width of the form for a new booking. The date picker is sized to match.
const _formWidth = 480.0;

/// What the booking form holds and its fields, for the page that creates a
/// booking and the overlay that changes one.
mixin _BookingForm<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  /// The booking that is changed, or null if a new one is created.
  Booking? get booking;

  late final _titleController = TextEditingController(text: booking?.title);
  late final _guestsController = TextEditingController(
    text: booking?.expectedGuestCount?.toString(),
  );
  late final _notesController = TextEditingController(text: booking?.notes);
  late DateTimeRange? _dates = _initialDates();
  late Contact? _lead = booking?.lead;
  late int? _organizationId = booking?.organizationId;
  late int? _categoryId = booking?.categoryId;
  late BookingStatus _status = booking?.status ?? BookingStatus.inquiry;
  late DateTime? _optionExpiresAt = switch (booking?.optionExpiresAt) {
    final expiry? => toLocalDate(expiry),
    null => null,
  };
  late int? _mealPlanId = booking?.mealPlanId;
  late BillingMode _billingMode = booking?.billingMode ?? BillingMode.single;

  DateTimeRange? _initialDates() {
    final start = booking?.startDay;
    final end = booking?.endDay;
    if (start == null || end == null) return null;
    return DateTimeRange(start: start, end: end);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _guestsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  /// The fields of the form from top to bottom.
  List<Widget> fields(BuildContext context) {
    final t = context.t.bookings;
    final organizations = ref.watch(organizationsProvider).value ?? [];
    final mealPlans = ref.watch(mealPlansProvider).value ?? [];
    final categories = ref.watch(bookingCategoriesProvider).value ?? [];

    return [
      TextFormField(
        controller: _titleController,
        autofocus: true,
        decoration: InputDecoration(labelText: t.titleField),
        validator: (value) =>
            value == null || value.trim().isEmpty ? t.required : null,
      ),
      _DatesField(
        dates: _dates,
        onChanged: (dates) => setState(() => _dates = dates),
      ),
      _LeadField(
        lead: _lead,
        onChanged: (lead) => setState(() => _lead = lead),
      ),
      Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int?>(
              // Built anew to show a category that was just created.
              key: ValueKey((_categoryId, categories.length)),
              isExpanded: true,
              initialValue: categories.any((c) => c.id == _categoryId)
                  ? _categoryId
                  : null,
              decoration: InputDecoration(labelText: t.category),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(context.t.common.none),
                ),
                for (final category in categories)
                  DropdownMenuItem(
                    value: category.id,
                    child: Row(
                      children: [
                        Icon(
                          category.icon.data,
                          size: 20,
                          color: category.color.color,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            category.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
              onChanged: (id) => setState(() => _categoryId = id),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: t.newCategory,
            icon: const Icon(YaruIcons.plus),
            onPressed: _addCategory,
          ),
        ],
      ),
      // "None" is the null entry.
      DropdownButtonFormField<int?>(
        isExpanded: true,
        initialValue: organizations.any((o) => o.id == _organizationId)
            ? _organizationId
            : null,
        decoration: InputDecoration(labelText: t.organization),
        items: [
          DropdownMenuItem(value: null, child: Text(context.t.common.none)),
          for (final organization in organizations)
            DropdownMenuItem(
              value: organization.id,
              child: Text(organization.name),
            ),
        ],
        onChanged: (id) => setState(() => _organizationId = id),
      ),
      DropdownButtonFormField<BookingStatus>(
        isExpanded: true,
        initialValue: _status,
        decoration: InputDecoration(labelText: t.status),
        items: [
          for (final status in BookingStatus.values)
            DropdownMenuItem(value: status, child: Text(status.label(context))),
        ],
        onChanged: (status) => setState(() => _status = status ?? _status),
      ),
      if (_status == BookingStatus.option)
        DateField(
          label: t.optionExpiresAt,
          date: _optionExpiresAt,
          onChanged: (date) => setState(() => _optionExpiresAt = date),
        ),
      DropdownButtonFormField<int?>(
        isExpanded: true,
        initialValue: mealPlans.any((p) => p.id == _mealPlanId)
            ? _mealPlanId
            : null,
        decoration: InputDecoration(labelText: t.mealPlan),
        items: [
          DropdownMenuItem(value: null, child: Text(context.t.common.none)),
          for (final plan in mealPlans)
            DropdownMenuItem(value: plan.id, child: Text(plan.name)),
        ],
        onChanged: (id) => setState(() => _mealPlanId = id),
      ),
      DropdownButtonFormField<BillingMode>(
        isExpanded: true,
        initialValue: _billingMode,
        decoration: InputDecoration(labelText: t.billingMode),
        items: [
          for (final mode in BillingMode.values)
            DropdownMenuItem(value: mode, child: Text(mode.label(context))),
        ],
        onChanged: (mode) =>
            setState(() => _billingMode = mode ?? _billingMode),
      ),
      IntField(
        controller: _guestsController,
        label: t.expectedGuests,
        optional: true,
      ),
      TextFormField(
        controller: _notesController,
        minLines: 2,
        maxLines: 6,
        decoration: InputDecoration(labelText: t.notes),
      ),
    ];
  }

  /// Lets the user create a category, which the booking then has.
  Future<void> _addCategory() async {
    await showAdminDialog(
      context,
      BookingCategoryDialog(
        onSaved: (category) {
          ref.invalidate(bookingCategoriesProvider);
          if (mounted) setState(() => _categoryId = category.id);
        },
      ),
    );
  }

  /// Saves the booking as the form has it, which must be valid, and returns
  /// it as the server stored it.
  Future<Booking> submit() async {
    final existing = booking;
    final dates = _dates;
    final expiry = _optionExpiresAt;
    final edited = Booking(
      id: existing?.id,
      createdAt: existing?.createdAt,
      title: _titleController.text.trim(),
      arrival: dates == null ? null : toUtcDate(dates.start),
      departure: dates == null ? null : toUtcDate(dates.end),
      leadId: _lead!.id!,
      organizationId: _organizationId,
      categoryId: _categoryId,
      status: _status,
      // Only an option can run out.
      optionExpiresAt: _status == BookingStatus.option && expiry != null
          ? toUtcDate(expiry)
          : null,
      mealPlanId: _mealPlanId,
      billingMode: _billingMode,
      expectedGuestCount: int.tryParse(_guestsController.text.trim()),
      notes: nullIfBlank(_notesController.text),
    );
    final endpoint = ref.read(serverpodClientProvider).booking;
    final saved = existing == null
        ? await endpoint.add(edited)
        : await endpoint.update(edited);
    ref.invalidate(bookingsProvider);
    ref.read(statusProvider.notifier).saved();
    return saved;
  }
}

/// The form of a [tab] in which a new booking is created. Once the booking
/// is saved, the tab shows it.
class NewBookingForm extends ConsumerStatefulWidget {
  const NewBookingForm({super.key, required this.tab});

  final BookingTab tab;

  @override
  ConsumerState<NewBookingForm> createState() => _NewBookingFormState();
}

class _NewBookingFormState extends ConsumerState<NewBookingForm>
    with _BookingForm<NewBookingForm> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  Object? _error;

  @override
  Booking? get booking => null;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final tabs = ref.read(tabsProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(kYaruPagePadding),
      child: Center(
        child: SizedBox(
          width: _formWidth,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.newBooking,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                for (final field in fields(context)) ...[
                  const SizedBox(height: 16),
                  field,
                ],
                if (_error case final error?) ...[
                  const SizedBox(height: 16),
                  Text(
                    validationMessage(context, error) ??
                        t.saveFailed(error: error),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _saving ? null : () => tabs.close(widget.tab),
                      child: Text(t.cancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _saving ? null : _save,
                      child: Text(t.save),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final saved = await submit();
      ref
          .read(tabsProvider.notifier)
          .update(widget.tab.copyWith(booking: saved));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = error;
      });
    }
  }
}

/// The overlay that changes what the overview of the booking of [tab]
/// shows: its title, dates, lead, status and so on.
class BookingOverviewEditor extends ConsumerStatefulWidget {
  const BookingOverviewEditor({super.key, required this.tab});

  final BookingTab tab;

  @override
  ConsumerState<BookingOverviewEditor> createState() =>
      _BookingOverviewEditorState();
}

class _BookingOverviewEditorState extends ConsumerState<BookingOverviewEditor>
    with _BookingForm<BookingOverviewEditor> {
  @override
  Booking? get booking => widget.tab.booking;

  @override
  Widget build(BuildContext context) {
    return AdminFormDialog(
      title: context.t.bookings.editBooking,
      onSave: () async {
        final saved = await submit();
        ref
            .read(tabsProvider.notifier)
            .update(widget.tab.copyWith(booking: saved));
      },
      children: fields(context),
    );
  }
}

class _DatesField extends StatelessWidget {
  const _DatesField({required this.dates, required this.onChanged});

  final DateTimeRange? dates;
  final ValueChanged<DateTimeRange?> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final l10n = MaterialLocalizations.of(context);
    final dates = this.dates;

    return InkWell(
      onTap: () => _pick(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: t.dates,
          suffixIcon: dates == null
              ? const Icon(Icons.date_range)
              : IconButton(
                  tooltip: t.clearDates,
                  icon: const Icon(Icons.clear),
                  onPressed: () => onChanged(null),
                ),
        ),
        child: Text(
          dates == null
              ? t.noDates
              : dates.start == dates.end
              ? l10n.formatShortDate(dates.start)
              : '${l10n.formatShortDate(dates.start)} – '
                    '${l10n.formatShortDate(dates.end)}',
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: dates,
      currentDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
      // The range picker is always full screen; shrink it to a dialog sized
      // like the booking form instead.
      builder: (context, child) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: _formWidth + 48,
            maxHeight: 600,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: child,
          ),
        ),
      ),
    );
    if (picked != null) onChanged(picked);
  }
}

/// Picks the lead from the existing contacts.
class _LeadField extends ConsumerWidget {
  const _LeadField({required this.lead, required this.onChanged});

  final Contact? lead;
  final ValueChanged<Contact?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final contacts = ref.watch(contactsProvider);
    final lead = this.lead;

    return switch (contacts) {
      AsyncData(value: final contacts) => FormField<Contact>(
        initialValue: lead,
        validator: (_) => this.lead == null ? t.required : null,
        builder: (field) {
          return DropdownMenu<Contact>(
            // The contacts are loaded anew, so the lead is found by its id.
            initialSelection: contacts
                .where((c) => lead != null && c.id == lead.id)
                .firstOrNull,
            label: Text(t.leadField),
            errorText: field.errorText,
            expandedInsets: EdgeInsets.zero,
            enableFilter: true,
            requestFocusOnTap: true,
            onSelected: (contact) {
              field.didChange(contact);
              onChanged(contact);
            },
            dropdownMenuEntries: [
              for (final contact in contacts)
                DropdownMenuEntry(value: contact, label: contact.fullName),
            ],
          );
        },
      ),
      AsyncError(:final error) => Text(
        context.t.common.loadFailed(error: error),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
