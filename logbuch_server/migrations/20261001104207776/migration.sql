BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "contacts" ADD COLUMN "mail" text;
ALTER TABLE "contacts" ADD COLUMN "phone" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "rooms" (
    "id" bigserial PRIMARY KEY,
    "roomNumber" text NOT NULL,
    "bedAmount" bigint NOT NULL
);


--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261001104207776', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261001104207776', "timestamp" = now();

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
