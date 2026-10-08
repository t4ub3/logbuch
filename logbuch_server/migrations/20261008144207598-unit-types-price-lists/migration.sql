BEGIN;

--
-- DATA: keep what the tables hold that are dropped or made anew below.
-- Seasons become price lists, price categories become unit types and the
-- buildings named by the rooms become buildings.
--
CREATE TEMP TABLE "_old_seasons" ON COMMIT DROP AS SELECT * FROM "seasons";
CREATE TEMP TABLE "_old_price_categories" ON COMMIT DROP AS SELECT * FROM "price_categories";
CREATE TEMP TABLE "_old_room_rates" ON COMMIT DROP AS SELECT * FROM "room_rates";
CREATE TEMP TABLE "_old_meal_rates" ON COMMIT DROP AS SELECT * FROM "meal_rates";
CREATE TEMP TABLE "_old_rooms" ON COMMIT DROP AS SELECT * FROM "rooms";
CREATE TEMP TABLE "_old_fees" ON COMMIT DROP AS SELECT "id", "amount" FROM "fees";

--
-- ACTION DROP TABLE
--
DROP TABLE "seasons" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "price_categories" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "buildings" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "fee_prices" (
    "id" bigserial PRIMARY KEY,
    "priceListId" bigint NOT NULL,
    "feeId" bigint NOT NULL,
    "amount" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "fee_prices_unique_idx" ON "fee_prices" USING btree ("priceListId", "feeId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "fees" DROP COLUMN "amount";
--
-- ACTION DROP TABLE
--
DROP TABLE "meal_rates" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_rates" (
    "id" bigserial PRIMARY KEY,
    "priceListId" bigint NOT NULL,
    "mealPlanId" bigint NOT NULL,
    "ageGroupId" bigint NOT NULL,
    "pricePerNight" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "meal_rates_unique_idx" ON "meal_rates" USING btree ("priceListId", "mealPlanId", "ageGroupId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "price_lists" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "validFrom" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "price_lists_valid_from_idx" ON "price_lists" USING btree ("validFrom");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_fees" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "feeId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_fees_unique_idx" ON "room_fees" USING btree ("roomId", "feeId");

--
-- ACTION DROP TABLE
--
DROP TABLE "room_rates" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_rates" (
    "id" bigserial PRIMARY KEY,
    "priceListId" bigint NOT NULL,
    "unitTypeId" bigint NOT NULL,
    "ageGroupId" bigint NOT NULL,
    "pricePerNight" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_rates_unique_idx" ON "room_rates" USING btree ("priceListId", "unitTypeId", "ageGroupId");

--
-- ACTION DROP TABLE
--
DROP TABLE "rooms" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rooms" (
    "id" bigserial PRIMARY KEY,
    "roomNumber" text NOT NULL,
    "bedAmount" bigint NOT NULL,
    "buildingId" bigint,
    "floor" text,
    "unitTypeId" bigint NOT NULL,
    "cribPossible" boolean NOT NULL DEFAULT false,
    "active" boolean NOT NULL DEFAULT true,
    "notes" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "unit_prices" (
    "id" bigserial PRIMARY KEY,
    "priceListId" bigint NOT NULL,
    "unitTypeId" bigint NOT NULL,
    "pricePerNight" bigint,
    "dayUsePrice" bigint
);

-- Indexes
CREATE UNIQUE INDEX "unit_prices_unique_idx" ON "unit_prices" USING btree ("priceListId", "unitTypeId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "unit_types" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "taxRate" bigint NOT NULL DEFAULT 700,
    "shared" boolean NOT NULL DEFAULT false
);

--
-- DATA: fill the new tables. Records keep their ids, so that what refers
-- to them still does, and the sequences go on after the highest id.
--
INSERT INTO "unit_types" ("id", "name", "sortOrder")
    SELECT "id", "name", "sortOrder" FROM "_old_price_categories";
SELECT setval(pg_get_serial_sequence('"unit_types"', 'id'), coalesce(max("id"), 1), max("id") IS NOT NULL) FROM "unit_types";

-- A season becomes the price list that holds from its first day on.
INSERT INTO "price_lists" ("id", "name", "validFrom")
    SELECT "id", "name", "validFrom" FROM "_old_seasons";
SELECT setval(pg_get_serial_sequence('"price_lists"', 'id'), coalesce(max("id"), 1), max("id") IS NOT NULL) FROM "price_lists";
-- Without a season there is still a list for what the fees cost.
INSERT INTO "price_lists" ("name", "validFrom")
    SELECT 'Preise', '2020-01-01'
    WHERE NOT EXISTS (SELECT 1 FROM "_old_seasons")
      AND EXISTS (SELECT 1 FROM "_old_fees");

INSERT INTO "buildings" ("name", "sortOrder")
    SELECT "name", row_number() OVER (ORDER BY "name") - 1
    FROM (
        SELECT DISTINCT btrim("building") AS "name" FROM "_old_rooms"
        WHERE btrim("building") <> ''
    ) AS "named";

INSERT INTO "rooms" ("id", "roomNumber", "bedAmount", "buildingId", "floor", "unitTypeId", "cribPossible", "active", "notes")
    SELECT r."id", r."roomNumber", r."bedAmount", b."id", r."floor", r."priceCategoryId", r."cribPossible", r."active", r."notes"
    FROM "_old_rooms" r
    LEFT JOIN "buildings" b ON b."name" = btrim(r."building");
SELECT setval(pg_get_serial_sequence('"rooms"', 'id'), coalesce(max("id"), 1), max("id") IS NOT NULL) FROM "rooms";

INSERT INTO "room_rates" ("id", "priceListId", "unitTypeId", "ageGroupId", "pricePerNight")
    SELECT "id", "seasonId", "priceCategoryId", "ageGroupId", "pricePerNight" FROM "_old_room_rates";
SELECT setval(pg_get_serial_sequence('"room_rates"', 'id'), coalesce(max("id"), 1), max("id") IS NOT NULL) FROM "room_rates";

INSERT INTO "meal_rates" ("id", "priceListId", "mealPlanId", "ageGroupId", "pricePerNight")
    SELECT "id", "seasonId", "mealPlanId", "ageGroupId", "pricePerNight" FROM "_old_meal_rates";
SELECT setval(pg_get_serial_sequence('"meal_rates"', 'id'), coalesce(max("id"), 1), max("id") IS NOT NULL) FROM "meal_rates";

-- A fee cost the same all year, so it does in every list.
INSERT INTO "fee_prices" ("priceListId", "feeId", "amount")
    SELECT l."id", f."id", f."amount" FROM "price_lists" l CROSS JOIN "_old_fees" f;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fee_prices"
    ADD CONSTRAINT "fee_prices_fk_0"
    FOREIGN KEY("priceListId")
    REFERENCES "price_lists"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "fee_prices"
    ADD CONSTRAINT "fee_prices_fk_1"
    FOREIGN KEY("feeId")
    REFERENCES "fees"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meal_rates"
    ADD CONSTRAINT "meal_rates_fk_0"
    FOREIGN KEY("priceListId")
    REFERENCES "price_lists"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "meal_rates"
    ADD CONSTRAINT "meal_rates_fk_1"
    FOREIGN KEY("mealPlanId")
    REFERENCES "meal_plans"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "meal_rates"
    ADD CONSTRAINT "meal_rates_fk_2"
    FOREIGN KEY("ageGroupId")
    REFERENCES "age_groups"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_fees"
    ADD CONSTRAINT "room_fees_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "rooms"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_fees"
    ADD CONSTRAINT "room_fees_fk_1"
    FOREIGN KEY("feeId")
    REFERENCES "fees"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_rates"
    ADD CONSTRAINT "room_rates_fk_0"
    FOREIGN KEY("priceListId")
    REFERENCES "price_lists"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_rates"
    ADD CONSTRAINT "room_rates_fk_1"
    FOREIGN KEY("unitTypeId")
    REFERENCES "unit_types"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_rates"
    ADD CONSTRAINT "room_rates_fk_2"
    FOREIGN KEY("ageGroupId")
    REFERENCES "age_groups"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "rooms"
    ADD CONSTRAINT "rooms_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "buildings"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "rooms"
    ADD CONSTRAINT "rooms_fk_1"
    FOREIGN KEY("unitTypeId")
    REFERENCES "unit_types"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "unit_prices"
    ADD CONSTRAINT "unit_prices_fk_0"
    FOREIGN KEY("priceListId")
    REFERENCES "price_lists"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "unit_prices"
    ADD CONSTRAINT "unit_prices_fk_1"
    FOREIGN KEY("unitTypeId")
    REFERENCES "unit_types"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION RESTORE FOREIGN KEY
--
ALTER TABLE ONLY "booking_rooms"
    ADD CONSTRAINT "booking_rooms_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "rooms"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261008144207598-unit-types-price-lists', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008144207598-unit-types-price-lists', "timestamp" = now();

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
