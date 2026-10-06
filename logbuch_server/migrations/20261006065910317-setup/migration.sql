BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "age_groups" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "minAge" bigint NOT NULL,
    "maxAge" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "fees" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "amount" bigint NOT NULL,
    "unit" text NOT NULL,
    "ageGroupId" bigint,
    "taxRate" bigint NOT NULL DEFAULT 0,
    "autoApply" boolean NOT NULL DEFAULT false
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_plans" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_rates" (
    "id" bigserial PRIMARY KEY,
    "seasonId" bigint NOT NULL,
    "mealPlanId" bigint NOT NULL,
    "ageGroupId" bigint NOT NULL,
    "pricePerNight" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "meal_rates_unique_idx" ON "meal_rates" USING btree ("seasonId", "mealPlanId", "ageGroupId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "price_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_rates" (
    "id" bigserial PRIMARY KEY,
    "seasonId" bigint NOT NULL,
    "priceCategoryId" bigint NOT NULL,
    "ageGroupId" bigint NOT NULL,
    "pricePerNight" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_rates_unique_idx" ON "room_rates" USING btree ("seasonId", "priceCategoryId", "ageGroupId");

--
-- ACTION ALTER TABLE
--
-- Edited by hand. The generated migration dropped and recreated "rooms",
-- because the new "priceCategoryId" is required and has no default. Instead
-- the existing rooms are kept and put into a "Standard" price category.
ALTER TABLE "rooms" ADD COLUMN "building" text;
ALTER TABLE "rooms" ADD COLUMN "floor" text;
ALTER TABLE "rooms" ADD COLUMN "priceCategoryId" bigint;
ALTER TABLE "rooms" ADD COLUMN "cribPossible" boolean NOT NULL DEFAULT false;
ALTER TABLE "rooms" ADD COLUMN "active" boolean NOT NULL DEFAULT true;
ALTER TABLE "rooms" ADD COLUMN "notes" text;

INSERT INTO "price_categories" ("name")
    SELECT 'Standard' WHERE EXISTS (SELECT 1 FROM "rooms");
UPDATE "rooms"
    SET "priceCategoryId" = (SELECT min("id") FROM "price_categories");
ALTER TABLE "rooms" ALTER COLUMN "priceCategoryId" SET NOT NULL;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "seasons" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "validFrom" timestamp without time zone NOT NULL,
    "validTo" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fees"
    ADD CONSTRAINT "fees_fk_0"
    FOREIGN KEY("ageGroupId")
    REFERENCES "age_groups"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meal_rates"
    ADD CONSTRAINT "meal_rates_fk_0"
    FOREIGN KEY("seasonId")
    REFERENCES "seasons"("id")
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
ALTER TABLE ONLY "room_rates"
    ADD CONSTRAINT "room_rates_fk_0"
    FOREIGN KEY("seasonId")
    REFERENCES "seasons"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_rates"
    ADD CONSTRAINT "room_rates_fk_1"
    FOREIGN KEY("priceCategoryId")
    REFERENCES "price_categories"("id")
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
    FOREIGN KEY("priceCategoryId")
    REFERENCES "price_categories"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006065910317-setup', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006065910317-setup', "timestamp" = now();

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
