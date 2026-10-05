import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/tabs_provider.dart';
import 'package:yaru/yaru.dart';

/// Width of the booking form. The date picker is sized to match.
const _formWidth = 480.0;

/// Form to create a new booking, or to edit the booking of [tab].
class BookingEditor extends ConsumerStatefulWidget {
  const BookingEditor({super.key, required this.tab});

  final BookingTab tab;

  @override
  ConsumerState<BookingEditor> createState() => _BookingEditorState();
}

class _BookingEditorState extends ConsumerState<BookingEditor> {
  Booking? get _booking => widget.tab.booking;

  final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(text: _booking?.title);
  late DateTimeRange? _dates = _initialDates();
  late Contact? _lead = _booking?.lead;
  bool _saving = false;
  Object? _error;

  DateTimeRange? _initialDates() {
    final start = _booking?.startDay;
    final end = _booking?.endDay;
    if (start == null || end == null) return null;
    return DateTimeRange(start: start, end: end);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;

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
                  _booking == null ? t.newBooking : t.editBooking,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: InputDecoration(labelText: t.titleField),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? t.required : null,
                ),
                const SizedBox(height: 16),
                _DatesField(
                  dates: _dates,
                  onChanged: (dates) => setState(() => _dates = dates),
                ),
                const SizedBox(height: 16),
                _LeadField(
                  lead: _lead,
                  onChanged: (lead) => setState(() => _lead = lead),
                ),
                if (_error case final error?) ...[
                  const SizedBox(height: 16),
                  Text(
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
                      onPressed: _saving ? null : _cancel,
                      child: Text(t.cancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
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

  /// New bookings close their tab, existing ones return to their details.
  void _cancel() {
    final tabs = ref.read(tabsProvider.notifier);
    if (_booking == null) {
      tabs.close(widget.tab);
    } else {
      tabs.update(widget.tab.copyWith(editing: false));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    // Dates are stored as the start of the first and last day.
    final from = _dates?.start;
    final to = _dates?.end;
    final lead = _lead!;
    final existing = _booking;
    final endpoint = ref.read(serverpodClientProvider).booking;

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final saved = existing == null
          ? await endpoint.add(
              Booking(title: title, from: from, to: to, lead: lead),
            )
          : await endpoint.update(
              existing.copyWith(title: title, from: from, to: to, lead: lead),
            );
      ref.invalidate(bookingsProvider);
      // Show the details of the saved booking in this tab.
      ref
          .read(tabsProvider.notifier)
          .update(widget.tab.copyWith(booking: saved, editing: false));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = error;
      });
    }
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

/// Picks the lead from the existing contacts. The booking stores a copy of
/// the contact, so contacts are matched by id.
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
          // Keep the current lead selectable even if the contact no longer
          // exists.
          final options = [
            ...contacts,
            if (lead != null && !contacts.any((c) => c.id == lead.id)) lead,
          ];
          return DropdownMenu<Contact>(
            initialSelection: options
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
              for (final contact in options)
                DropdownMenuEntry(
                  value: contact,
                  label: '${contact.firstName} ${contact.lastName}',
                ),
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
