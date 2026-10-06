BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "donation_receipts" (
    "id" bigserial PRIMARY KEY,
    "contactId" bigint NOT NULL,
    "year" bigint NOT NULL,
    "number" text NOT NULL,
    "total" bigint NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL,
    "pdf" bytea
);

-- Indexes
CREATE UNIQUE INDEX "donation_receipts_number_idx" ON "donation_receipts" USING btree ("number");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "donations" ADD COLUMN "receiptId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "operator" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "street" text NOT NULL,
    "zip" text NOT NULL,
    "city" text NOT NULL,
    "taxOffice" text NOT NULL,
    "taxNumber" text NOT NULL,
    "noticeType" text NOT NULL DEFAULT 'statutoryCompliance'::text,
    "noticeDate" timestamp without time zone,
    "assessmentPeriod" text,
    "purposes" text NOT NULL,
    "purposesObject" text,
    "place" text NOT NULL,
    "signatory" text
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "donation_receipts"
    ADD CONSTRAINT "donation_receipts_fk_0"
    FOREIGN KEY("contactId")
    REFERENCES "contacts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "donations"
    ADD CONSTRAINT "donations_fk_2"
    FOREIGN KEY("receiptId")
    REFERENCES "donation_receipts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006085339329-receipts', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006085339329-receipts', "timestamp" = now();

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
