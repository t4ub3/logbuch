BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "booking_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "icon" text NOT NULL,
    "color" text NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "bookings" DROP CONSTRAINT IF EXISTS "bookings_fk_2";
ALTER TABLE "bookings" ADD COLUMN "categoryId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bookings"
    ADD CONSTRAINT "bookings_fk_3"
    FOREIGN KEY("mealPlanId")
    REFERENCES "meal_plans"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bookings"
    ADD CONSTRAINT "bookings_fk_2"
    FOREIGN KEY("categoryId")
    REFERENCES "booking_categories"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261007105459786-booking-categories', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007105459786-booking-categories', "timestamp" = now();

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
