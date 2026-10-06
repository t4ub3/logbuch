BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "charges" (
    "id" bigserial PRIMARY KEY,
    "folioId" bigint NOT NULL,
    "guestId" bigint,
    "type" text NOT NULL,
    "description" text NOT NULL,
    "quantity" bigint NOT NULL,
    "unitPrice" bigint NOT NULL,
    "total" bigint NOT NULL,
    "taxRate" bigint NOT NULL,
    "periodFrom" timestamp without time zone,
    "periodTo" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "donations" (
    "id" bigserial PRIMARY KEY,
    "contactId" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "paymentId" bigint,
    "source" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "folios" (
    "id" bigserial PRIMARY KEY,
    "bookingId" bigint NOT NULL,
    "payerId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'open'::text,
    "invoiceNumber" text,
    "invoicedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "folios_booking_payer_idx" ON "folios" USING btree ("bookingId", "payerId");
CREATE UNIQUE INDEX "folios_invoice_number_idx" ON "folios" USING btree ("invoiceNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payments" (
    "id" bigserial PRIMARY KEY,
    "folioId" bigint NOT NULL,
    "payerId" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "method" text NOT NULL,
    "reference" text
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "charges"
    ADD CONSTRAINT "charges_fk_0"
    FOREIGN KEY("folioId")
    REFERENCES "folios"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "charges"
    ADD CONSTRAINT "charges_fk_1"
    FOREIGN KEY("guestId")
    REFERENCES "guests"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "donations"
    ADD CONSTRAINT "donations_fk_0"
    FOREIGN KEY("contactId")
    REFERENCES "contacts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "donations"
    ADD CONSTRAINT "donations_fk_1"
    FOREIGN KEY("paymentId")
    REFERENCES "payments"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "folios"
    ADD CONSTRAINT "folios_fk_0"
    FOREIGN KEY("bookingId")
    REFERENCES "bookings"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "folios"
    ADD CONSTRAINT "folios_fk_1"
    FOREIGN KEY("payerId")
    REFERENCES "contacts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payments"
    ADD CONSTRAINT "payments_fk_0"
    FOREIGN KEY("folioId")
    REFERENCES "folios"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payments"
    ADD CONSTRAINT "payments_fk_1"
    FOREIGN KEY("payerId")
    REFERENCES "contacts"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006082922372-billing', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006082922372-billing', "timestamp" = now();

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
