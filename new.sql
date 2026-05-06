CREATE SCHEMA "public";
CREATE TABLE "_dlt_loads" (
	"load_id" varchar(64) NOT NULL,
	"schema_name" varchar,
	"status" bigint NOT NULL,
	"inserted_at" timestamp with time zone NOT NULL,
	"schema_version_hash" varchar
);
CREATE TABLE "_dlt_pipeline_state" (
	"version" bigint NOT NULL,
	"engine_version" bigint NOT NULL,
	"pipeline_name" varchar NOT NULL,
	"state" varchar NOT NULL,
	"created_at" timestamp with time zone NOT NULL,
	"version_hash" varchar,
	"_dlt_load_id" varchar(64) NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "_dlt_pipeline_state__dlt_id_key" UNIQUE
);
CREATE TABLE "_dlt_version" (
	"version" bigint NOT NULL,
	"engine_version" bigint NOT NULL,
	"inserted_at" timestamp with time zone NOT NULL,
	"schema_name" varchar NOT NULL,
	"version_hash" varchar NOT NULL,
	"schema" varchar NOT NULL
);
CREATE TABLE "alembic_version" (
	"version_num" varchar(32),
	CONSTRAINT "alembic_version_pkc" PRIMARY KEY("version_num")
);
CREATE TABLE "all_tree" (
	"id" varchar,
	"chi_muc" varchar,
	"mapc" varchar,
	"ten" varchar,
	"chu_de_id" varchar,
	"de_muc_id" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "all_tree__dlt_id_key" UNIQUE
);
CREATE TABLE "chu_de" (
	"value" varchar,
	"text" varchar,
	"stt" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "chu_de__dlt_id_key" UNIQUE
);
CREATE TABLE "de_muc" (
	"value" varchar,
	"text" varchar,
	"chu_de" varchar,
	"stt" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "de_muc__dlt_id_key" UNIQUE
);
CREATE TABLE "request_logs" (
	"id" uuid PRIMARY KEY,
	"request_id" varchar(255),
	"method" varchar(10) NOT NULL,
	"url" varchar(255) NOT NULL,
	"client_ip" varchar(50),
	"status_code" integer NOT NULL,
	"request_payload" json,
	"response_payload" json,
	"process_time" double precision NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
CREATE UNIQUE INDEX "_dlt_pipeline_state__dlt_id_key" ON "_dlt_pipeline_state" ("_dlt_id");
CREATE UNIQUE INDEX "alembic_version_pkc" ON "alembic_version" ("version_num");
CREATE UNIQUE INDEX "all_tree__dlt_id_key" ON "all_tree" ("_dlt_id");
CREATE UNIQUE INDEX "chu_de__dlt_id_key" ON "chu_de" ("_dlt_id");
CREATE UNIQUE INDEX "de_muc__dlt_id_key" ON "de_muc" ("_dlt_id");
CREATE INDEX "ix_request_logs_id" ON "request_logs" ("id");
CREATE INDEX "ix_request_logs_request_id" ON "request_logs" ("request_id");
CREATE UNIQUE INDEX "request_logs_pkey" ON "request_logs" ("id");
