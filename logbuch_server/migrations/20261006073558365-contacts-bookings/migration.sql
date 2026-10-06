BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "booking_rooms" (
    "id" bigserial PRIMARY KEY,
    "bookingId" bigint NOT NULL,
    "roomId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "booking_rooms_unique_idx" ON "booking_rooms" USING btree ("bookingId", "roomId");

--
-- ACTION ALTER TABLE
--
-- Edited by hand. The generated migration dropped and recreated "bookings".
-- Instead the existing bookings are kept and converted:
-- * "from" and "to" become "arrival" and "departure". They were stored as
--   midnight in the local time of whoever saved them or as midnight UTC, and
--   become their date in Europe/Berlin at midnight UTC.
-- * "lead" held a copy of the contact and becomes a reference to it. A lead
--   whose contact no longer exists is added to the contacts again.
-- * The status follows the new values. Billing is tracked apart from the
--   booking from now on, so billed and paid bookings become completed.
ALTER TABLE "bookings" ADD COLUMN "arrival" timestamp without time zone;
ALTER TABLE "bookings" ADD COLUMN "departure" timestamp without time zone;
ALTER TABLE "bookings" ADD COLUMN "leadId" bigint;
ALTER TABLE "bookings" ADD COLUMN "organizationId" bigint;
ALTER TABLE "bookings" ADD COLUMN "optionExpiresAt" timestamp without time zone;
ALTER TABLE "bookings" ADD COLUMN "mealPlanId" bigint;
ALTER TABLE "bookings" ADD COLUMN "billingMode" text NOT NULL DEFAULT 'single'::text;
ALTER TABLE "bookings" ADD COLUMN "expectedGuestCount" bigint;
ALTER TABLE "bookings" ADD COLUMN "notes" text;

UPDATE "bookings" SET
    "arrival" = date_trunc('day', COALESCE("from", "to") AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Berlin'),
    "departure" = date_trunc('day', COALESCE("to", "from") AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Berlin');

UPDATE "bookings" b SET "leadId" = c."id"
    FROM "contacts" c
    WHERE c."id" = (b."lead"->>'id')::bigint;
ALTER TABLE "contacts" ADD COLUMN "_leadOfBooking" bigint;
INSERT INTO "contacts" ("firstName", "lastName", "mail", "phone", "_leadOfBooking")
    SELECT
        COALESCE("lead"->>'firstName', ''),
        COALESCE("lead"->>'lastName', ''),
        "lead"->>'mail',
        "lead"->>'phone',
        "id"
    FROM "bookings" WHERE "leadId" IS NULL;
UPDATE "bookings" b SET "leadId" = c."id"
    FROM "contacts" c
    WHERE c."_leadOfBooking" = b."id";
ALTER TABLE "contacts" DROP COLUMN "_leadOfBooking";
ALTER TABLE "bookings" ALTER COLUMN "leadId" SET NOT NULL;

UPDATE "bookings" SET "status" = CASE "status"
    WHEN 'booked' THEN 'confirmed'
    WHEN 'billed' THEN 'completed'
    WHEN 'paid' THEN 'completed'
    ELSE 'inquiry' END;
ALTER TABLE "bookings" ALTER COLUMN "status" SET DEFAULT 'inquiry'::text;

ALTER TABLE "bookings" DROP COLUMN "from";
ALTER TABLE "bookings" DROP COLUMN "to";
ALTER TABLE "bookings" DROP COLUMN "lead";

--
-- ACTION ALTER TABLE
--
ALTER TABLE "contacts" ADD COLUMN "birthDate" timestamp without time zone;
ALTER TABLE "contacts" ADD COLUMN "street" text;
ALTER TABLE "contacts" ADD COLUMN "zip" text;
ALTER TABLE "contacts" ADD COLUMN "city" text;
ALTER TABLE "contacts" ADD COLUMN "country" text;
ALTER TABLE "contacts" ADD COLUMN "organizationId" bigint;
ALTER TABLE "contacts" ADD COLUMN "notes" text;
ALTER TABLE "contacts" ADD COLUMN "privacyConsentAt" timestamp without time zone;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "organizations" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "street" text,
    "zip" text,
    "city" text,
    "country" text
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "booking_rooms"
    ADD CONSTRAINT "booking_rooms_fk_0"
    FOREIGN KEY("bookingId")
    REFERENCES "bookings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "booking_rooms"
    ADD CONSTRAINT "booking_rooms_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "rooms"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bookings"
    ADD CONSTRAINT "bookings_fk_0"
    FOREIGN KEY("leadId")
    REFERENCES "contacts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bookings"
    ADD CONSTRAINT "bookings_fk_1"
    FOREIGN KEY("organizationId")
    REFERENCES "organizations"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bookings"
    ADD CONSTRAINT "bookings_fk_2"
    FOREIGN KEY("mealPlanId")
    REFERENCES "meal_plans"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "contacts"
    ADD CONSTRAINT "contacts_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organizations"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006073558365-contacts-bookings', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006073558365-contacts-bookings', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
