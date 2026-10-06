BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invoice_documents" (
    "id" bigserial PRIMARY KEY,
    "folioId" bigint NOT NULL,
    "pdf" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "invoice_documents_folio_idx" ON "invoice_documents" USING btree ("folioId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "operator" ADD COLUMN "accountHolder" text;
ALTER TABLE "operator" ADD COLUMN "iban" text;
ALTER TABLE "operator" ADD COLUMN "bic" text;
ALTER TABLE "operator" ADD COLUMN "bankName" text;
ALTER TABLE "operator" ADD COLUMN "paymentTerms" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invoice_documents"
    ADD CONSTRAINT "invoice_documents_fk_0"
    FOREIGN KEY("folioId")
    REFERENCES "folios"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR logbuch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('logbuch', '20261006092753931-invoices', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006092753931-invoices', "timestamp" = now();

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
