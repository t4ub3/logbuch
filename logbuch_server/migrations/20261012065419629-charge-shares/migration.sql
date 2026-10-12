BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "charges" ADD COLUMN "bookingRoomId" bigint;
ALTER TABLE "charges" ADD COLUMN "sharers" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "charges"
    ADD CONSTRAINT "charges_fk_2"
    FOREIGN KEY("bookingRoomId")
    REFERENCES "booking_rooms"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261012065419629-charge-shares', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261012065419629-charge-shares', "timestamp" = now();

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
