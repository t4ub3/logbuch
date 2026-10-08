# Handoff: buildings, unit types and price lists

State on 2026-10-08, evening. Nothing is committed; everything below is in the working tree.

## Where we stand

The restructuring for the first customer is written and tested, but **not yet applied to the development database and not yet seen running**.

- `serverpod start` stopped during the work and then failed to boot with "Database does not match target state", because the code had the new models and the database did not.
- The migration now exists: `logbuch_server/migrations/20261008144207598-unit-types-price-lists`. It was created with the CLI (`serverpod create-migration --force`), since the server could not start at all.
- The next `serverpod start` applies it on boot. That has not happened yet.

## Next steps, in order

1. Start `serverpod start` and confirm it boots. It applies the migration.
2. Check `tail_server_logs` and `tail_flutter_logs` (through the MCP bridge, see memory `serverpod-mcp-via-stdio-bridge`), then `hot_restart`.
3. Click through the app: the admin area (four groups, price list editor, surcharges on rooms and fees), a booking's Rooms and Price cards, the occupancy plan.
4. Decide the two open questions below.
5. Commit. The dimmed calendar bars from the start of the session are also uncommitted (`dimmed_accent.dart`, month and year view).

## Open decisions

- **Bungalows in the demo database:** it has none yet. `serverpod run seed` (in `logbuch_server`) would add four buildings, seven bungalows, their prices and three bungalow bookings, and keep everything else. Not run yet; waiting for a yes.
- **Price lists from seasons:** the migration turns each of the seven seasons into a price list with the same name and start date, so no price changes. Alternative: collapse them into one list per year, which shifts open (not invoiced) folios by about ±10 %.
- **Invoices and sharing:** if a booking is invoiced and another booking later joins the main bungalow for the same nights, the first invoice stays at full price while the second pays half. Should that be blocked or flagged?
- **Single room surcharge:** for now a property of the room. To be checked with the customer whether it should also apply when one guest sleeps alone in a double room.

## What was decided with the customer's structure in mind

- No seasons. Prices live in price lists with a valid-from date; the night of the stay decides which list applies.
- Main house and new building: price per guest and night by age group, plus surcharges assigned to rooms (bathroom, new building, single room). Children pay surcharges in full.
- Bungalows: price per bungalow and night, plus a price per guest by age group, plus a one-time final cleaning.
- Main bungalow: optional, bookable on its own, shared by any number of groups who split the nightly price. Warning when more than two share a night. Day use has its own fixed price.
- Meals for bungalow guests are separate meal plans, not a second price for the same plan.
- Billing per group or per guest: what is charged for a room is split evenly among the paying guests in it; a room nobody sleeps in is split among all paying guests of the booking.
- Each unit type has its own tax rate, starting at 7 %.

## What was built

Server (`logbuch_server`):
- New models: `Building`, `UnitType` (replaces `PriceCategory`), `PriceList` (replaces `Season`), `UnitPrice`, `FeePrice`, `RoomFee`, `PriceListPrices`. `RoomRate` and `MealRate` now hang on a price list; `Fee` lost its amount.
- New endpoints: `BuildingEndpoint`, `UnitTypeEndpoint`, `PriceListEndpoint` (replaces the season, room rate and meal rate endpoints). `RoomEndpoint` and `FeeEndpoint` take the surcharge assignment. `BookingEndpoint.crowdedRooms` is new.
- `lib/src/pricing/price_calculation.dart` is rewritten; `lib/src/billing/folio_distribution.dart` splits room charges.
- `tool/demo_data.dart` creates buildings, bungalows, price lists and bungalow bookings.

Flutter (`logbuch_flutter`):
- Admin area in four groups: House (buildings, rooms), Prices (unit types, age groups, meal plans, surcharges and fees, price lists), Bookings, Organisation.
- `lib/panels/admin/price_lists_section.dart` is the one place where amounts are entered.
- Booking page: warning for crowded shared rooms, new pricing problems. Occupancy plan sorts rooms by building and draws bookings that share a room on separate lines.

`AGENTS.md` is updated to describe all of this.

## Deviations from the agreed plan

- Final cleaning is a surcharge assigned to the bungalows, not a third price on the unit type, so it has a name on the invoice.
- Buildings have no self-catering flag; with separate meal plans it had no function.
- A fee without an amount in a price list is not charged, instead of being reported as a pricing problem.
- A held room whose unit type has no price of any kind is reported as a pricing problem, even when empty.

## Verified

- Server: `dart analyze` clean, all 246 tests pass (`dart test`), including the demo data seed on an empty database.
- Flutter: `dart analyze` clean, all 107 tests pass (`flutter test`).
- Migration: run on a copy of the development database. 30 rooms, 140 room rates, 105 meal rates, 3 fees, 91 guests and 287 charges came through, no booking lost a room, and the schema equals one built from `definition.sql` (apart from a column order in `bookings` that was there before).

Not verified: the migration on the real database, and anything in the running app.

## Safety net

- Backup from before the migration: `logbuch_server/.serverpod/logbuch_before_price_lists.dump` (pg_dump custom format). How to restore and how to reach the database is in memory `logbuch-dev-database-access`.
- `migration.sql` was edited by hand to carry the data over (the blocks marked `DATA:`). The other files of the migration are as generated.
