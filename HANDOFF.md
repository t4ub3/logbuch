# Handoff: buildings, unit types and price lists

State on 2026-10-12. The restructuring is committed (`7d0346b`); what was done on 2026-10-12 is in the working tree, not committed.

## Where we stand

- The migration to price lists ran on the development database. Server and app logs are clean.
- Clicked through in the running app: the admin area (four groups, room and fee dialogs with the surcharge assignment, price list editor), the occupancy plan, month view, and the Rooms, Price and Billing cards of bookings in the houses and in the bungalows.
- Found and fixed on the way: the form of a room that is in a building failed to open while the buildings were still loading (`rooms_section.dart`, with a test).
- The demo database has the bungalows now (`serverpod run seed`): Bungalowdorf with B1 to B4 and the shared Hauptbungalow, Ferienbungalows F1 and F2, their prices in all seven lists and three bookings. Backup from before: `logbuch_server/.serverpod/logbuch_before_bungalows.dump`.
- New: an invoice that charges a shared room for another split than the current one is flagged on the Rooms and Billing cards of the bookings involved (`BillingEndpoint.outdatedShares`, migration `20261012065419629-charge-shares`). See `AGENTS.md`.

## Next steps

1. Commit the working tree.
2. See the new warning in the running app. Nothing in the demo data triggers it: it needs a booking that is invoiced and then joined by another one in the Hauptbungalow.

## Decided on 2026-10-12

- **Price lists from seasons:** the seven lists stay as the migration made them. They can be renamed or deleted by hand.
- **Invoices and sharing:** flagged, not blocked. Invoices written before 2026-10-12 are never flagged, as their charges do not say which room they are for.

## Open decisions

- **Single room surcharge:** for now a property of the room. To be checked with the customer whether it should also apply when one guest sleeps alone in a double room.

## Seen in the app, not changed

- A room whose unit type and building have the same name reads "Haupthaus · Haupthaus" in the list of rooms.
- Bungalows are called "Zimmer B1" and "Zimmer Hauptbungalow" wherever a room is named.
- The fees Beamer, Comfort Zimmer and Endreinigung from before the migration are charged to nobody, as before. Comfort Zimmer can now be assigned to rooms; the other two are per booking.

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

- Server: `dart analyze` clean, all 258 tests pass (`dart test`), including the demo data seed on an empty database.
- Flutter: `dart analyze` clean, all 110 tests pass (`flutter test`).
- Migration: run on a copy of the development database. 30 rooms, 140 room rates, 105 meal rates, 3 fees, 91 guests and 287 charges came through, no booking lost a room, and the schema equals one built from `definition.sql` (apart from a column order in `bookings` that was there before).
- In the running app on the development database: see "Where we stand".

## Safety net

- Backup from before the migration: `logbuch_server/.serverpod/logbuch_before_price_lists.dump` (pg_dump custom format). How to restore and how to reach the database is in memory `logbuch-dev-database-access`.
- `migration.sql` was edited by hand to carry the data over (the blocks marked `DATA:`). The other files of the migration are as generated.
