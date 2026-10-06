# Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `logbuch_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `logbuch_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.

## The app

Log|Buch manages group guest houses (*Gruppenhäuser*) in Germany: bookings with guest lists, room assignment, billing per booking, per group or per guest, and donation receipts. Amounts are in EUR and the house is in the Europe/Berlin timezone. The UI is translated into English and German.

It is built in this order. Steps 1 to 7 and the login exist, the rest is planned. There are no deposits and no cancellation fees:

1. Setup and admin area: rooms, price categories, age groups, seasons, meal plans, room and meal rates, fees.
2. Contacts and organizations.
3. Bookings with the rooms they hold, availability, occupancy plan.
4. Guests in groups and the room assignment board. Dietary notes are an optional field of the guest, not of the contact.
5. Pricing engine that turns a booking into charges.
6. Folios, payments, billing modes, overpayments kept as donations.
7. Yearly donation receipts.
8. Imports are all that is left. The dashboard is the start screen; `buildDashboard` in `lib/src/dashboard/dashboard.dart` puts together arrivals and departures of today and the six days after, the occupancy tonight, options expiring within 14 days, invoices that are not paid in full, and the guests in the house today and tomorrow by age group. Invoices and booking confirmations exist as PDF. A confirmation (`lib/src/bookings/confirmation_pdf.dart`) is made anew on every request from the booking as it is, for bookings with dates that are an option or confirmed, and names a price only while all of the booking can be priced. Households exist as well: named sets of contacts under Contacts that `GuestEndpoint.addHousehold` adds to a booking as a guest group, leaving out members who are guests already. Imports wait until it is known what data the customers have in their current software. A guest list and a kitchen list as documents are not wanted: the guests are in the booking, and its Kitchen card sums them up by age group with their dietary needs (`buildKitchenOverview` in `lib/src/guests/kitchen_overview.dart`).

One installation manages one house. Some names are older than this plan and were kept: a booking has a `title` and a `lead`, a room a `roomNumber` and a `bedAmount`, a contact a `mail`.

## Conventions

- Money is an `int` in cents, never a `double`. Tax rates are an `int` in basis points, so 700 is 7 %.
- A date without a time of day (season bounds, later also arrival, departure and birth dates) is a `DateTime` at midnight UTC. The server rejects anything else with `requireDateOnly` in `lib/src/common/validation.dart`. The Flutter app converts with `toUtcDate` and `toLocalDate` in `lib/panels/admin/admin_formats.dart`.
- Seasons and age groups include both ends of their range and must not overlap.
- Prices are stored per season: a `RoomRate` per price category and age group, a `MealRate` per meal plan and age group. A missing rate means there is no price, which is not the same as a price of 0.
- Business rules are enforced on the server. An endpoint rejects invalid input with a `ValidationException`, whose `ValidationError` the Flutter app turns into a translated message with `validationMessage`.
- Users have one of two roles: an admin changes data, a viewer only reads. Every endpoint extends `AppEndpoint` in `lib/src/auth/roles.dart`, which requires a signed-in user with a role, and every method that changes data calls `requireAdmin(session)` first. Roles are scopes of the auth user and are read from the database on each call, so a change applies at once. The first user to sign up becomes admin; later users have no role until an admin gives them one.
- A booking's `arrival` and `departure` are dates without a time, and may both be missing. It holds its rooms for the nights in between, so a room is free again on the day of departure. Rooms are taken with `BookingEndpoint.setRooms`, which locks them inside a transaction; cancelled bookings hold nothing.
- A guest is a contact in a guest group of a booking. Guests are assigned to a `BookingRoom`, so only to rooms their booking holds. A room may hold more guests than it has beds while guests are moved around; the app shows that it is overfull, the server does not reject it.
- What a booking costs is calculated by `calculatePrice` in `lib/src/pricing/price_calculation.dart`, a function without database access. Each guest pays per night by the season of the night, the price category of their room and their age group, which is their age on the day they arrive unless one is set for the guest. Nothing is guessed: what cannot be priced is left out and returned as a `PricingProblem`. Empty beds cost nothing.
- All prices include tax. Lodging and meals are taxed at 7 % (`lodgingTaxRate`); a fee has its own rate, which starts at 7 % as well.
- A folio is the account of one payer for one booking. `distributeLines` in `lib/src/billing/folio_distribution.dart` decides who pays which line by the billing mode of the booking. `BillingEndpoint.getFolios` first brings the calculated charges of all folios that are not invoiced in line with the booking, so they are never stale; charges added by hand (`manual`, `discount`) are kept.
- Invoicing a folio gives it the next number of the year, such as `2026-0001`, and freezes its charges: later changes to rates, guests or rooms do not touch it, and the billing mode of the booking cannot change anymore. A folio cannot be invoiced while a part of the booking cannot be priced.
- The invoice of an invoiced folio is a PDF built by `lib/src/billing/invoice_pdf.dart`, in German. `BillingEndpoint.getInvoicePdf` produces it the first time it is asked for and stores it, so that it does not change afterwards; an admin can replace it with `renewInvoicePdf` while the invoice has not been sent. It needs the name, address and tax number of the operator; bank details and payment terms are printed if they were entered under Admin. Prices include tax, so the invoice states the tax contained in the total per tax rate (`taxShares`).
- A payment with a negative amount is a refund. What is paid beyond the charges stays a credit until the user decides. It becomes a `Donation` only through `BillingEndpoint.donate`, which the app calls when the user confirms that the payer wants to donate it. Never create donations from balances.
- `DonationEndpoint.createReceipts` issues one receipt (*Sammelbestätigung*) per donor for the donations of a year that are on none yet, numbered like `SB-2026-0001`. The PDF is built on the server by `lib/src/donations/receipt_pdf.dart` and stored with the receipt, so it stays as it was issued. A donation on a receipt can no longer be removed. A donor without a full address gets no receipt, and none are issued while the details of the operator (`Operator`, edited under Admin) are incomplete.
- The text of a receipt is in `lib/src/donations/receipt_text.dart`. It is German whatever the language of the app, and follows the official template, whose wording must be kept. The operator's notice from the tax office decides the first sentence; § 60a AO is the default until the operator has confirmed which notice applies.
- Server tests sign in with `withAdmin`, `asViewer` and `withoutRole` from `test/integration/roles.dart`. Tests of logic without a database are in `test/unit/`.

## Flutter app

- State lives in Riverpod providers with code generation, one provider per file in `lib/providers/`. Texts are in `lib/i18n/*.i18n.json` and always added in both languages. After changing a provider or a text, run `dart run build_runner build --delete-conflicting-outputs` in `logbuch_flutter`.
- The admin area is `lib/panels/admin_panel.dart`, with one file per section in `lib/panels/admin/`. Its lists and form dialogs are built from the widgets in `admin_widgets.dart`, which the contacts use as well.
- The main action of a screen or dialog (save, create, confirm) is an `ElevatedButton`, which the theme draws in the accent color. Lesser actions next to it are `OutlinedButton`s or `TextButton`s. `FilledButton` is not used: the theme draws it grey, which made it look weaker than the text button beside it.
- The page of a booking (`lib/panels/bookings/booking_details.dart`) is made of cards: the overview across the top, the others below it in two columns, or in one where the window is narrow. A card (`BookingCard` in `booking_card.dart`) only shows its part of the booking, so the page itself has no main button. A card with something to change has an outlined button with a pen that opens an overlay (`BookingOverlay`) for it; the kitchen and the price follow from the rest and have none. Card and overlay of a part are in one file, such as `booking_guests.dart`. Overlays are opened with `showBookingOverlay`, which loads what the other cards show again once the overlay closes, and gives the overlay a scaffold of its own for snack bars.
- `canEditProvider` says whether the signed-in user may change data. Everything that adds, edits or deletes is hidden from viewers.
- Run `flutter test` in `logbuch_flutter` after changing the app. Widget tests replace the Serverpod client with the fake in `test/fake_client.dart`.
