BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "household_members" (
    "id" bigserial PRIMARY KEY,
    "householdId" bigint NOT NULL,
    "contactId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "household_members_unique_idx" ON "household_members" USING btree ("householdId", "contactId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "households" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "household_members"
    ADD CONSTRAINT "household_members_fk_0"
    FOREIGN KEY("householdId")
    REFERENCES "households"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "household_members"
    ADD CONSTRAINT "household_members_fk_1"
    FOREIGN KEY("contactId")
    REFERENCES "contacts"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006100333978-households', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006100333978-households', "timestamp" = now();

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
