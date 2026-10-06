BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "guest_groups" (
    "id" bigserial PRIMARY KEY,
    "bookingId" bigint NOT NULL,
    "name" text NOT NULL,
    "payerId" bigint,
    "sortOrder" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "guests" (
    "id" bigserial PRIMARY KEY,
    "groupId" bigint NOT NULL,
    "contactId" bigint NOT NULL,
    "bookingRoomId" bigint,
    "needsCrib" boolean NOT NULL DEFAULT false,
    "ageGroupOverrideId" bigint,
    "arrivalOverride" timestamp without time zone,
    "departureOverride" timestamp without time zone,
    "dietaryNotes" text
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "guest_groups"
    ADD CONSTRAINT "guest_groups_fk_0"
    FOREIGN KEY("bookingId")
    REFERENCES "bookings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "guest_groups"
    ADD CONSTRAINT "guest_groups_fk_1"
    FOREIGN KEY("payerId")
    REFERENCES "contacts"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "guests"
    ADD CONSTRAINT "guests_fk_0"
    FOREIGN KEY("groupId")
    REFERENCES "guest_groups"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "guests"
    ADD CONSTRAINT "guests_fk_1"
    FOREIGN KEY("contactId")
    REFERENCES "contacts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "guests"
    ADD CONSTRAINT "guests_fk_2"
    FOREIGN KEY("bookingRoomId")
    REFERENCES "booking_rooms"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "guests"
    ADD CONSTRAINT "guests_fk_3"
    FOREIGN KEY("ageGroupOverrideId")
    REFERENCES "age_groups"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006081116750-guests', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006081116750-guests', "timestamp" = now();

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
