CREATE SCHEMA "public";
CREATE SCHEMA "public_staging";
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
CREATE TABLE "dim_doc_type" (
	"id" varchar NOT NULL,
	"code" varchar,
	"name" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "dim_doc_type__dlt_id_key" UNIQUE
);
CREATE TABLE "dim_eff_status" (
	"id" varchar NOT NULL,
	"code" varchar,
	"name" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "dim_eff_status__dlt_id_key" UNIQUE
);
CREATE TABLE "dim_major" (
	"id" varchar NOT NULL,
	"code" varchar,
	"name" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "dim_major__dlt_id_key" UNIQUE,
	"short_name" varchar
);
CREATE TABLE "document_chunking" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"md_hash" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_chunking__dlt_id_key" UNIQUE
);
CREATE TABLE "document_context" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"summary_md5" varchar,
	"chunk_md5" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_context__dlt_id_key" UNIQUE
);
CREATE TABLE "document_embedding" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"context_md5" varchar,
	"vector_count" bigint,
	"status" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_embedding__dlt_id_key" UNIQUE
);
CREATE TABLE "document_issues" (
	"id" varchar NOT NULL,
	"document_id" varchar,
	"agency_id" varchar,
	"agency_name" varchar,
	"person_id" varchar,
	"person_name" varchar,
	"job_title_code" varchar,
	"job_title_name" varchar,
	"order_index" bigint,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_issues__dlt_id_key" UNIQUE
);
CREATE TABLE "document_majors" (
	"document_id" varchar NOT NULL,
	"major_id" varchar NOT NULL,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_majors__dlt_id_key" UNIQUE
);
CREATE TABLE "document_markdown" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_markdown__dlt_id_key" UNIQUE
);
CREATE TABLE "document_references" (
	"id" varchar NOT NULL,
	"document_id" varchar,
	"target_document_id" varchar,
	"target_document_type" varchar,
	"target_document_num" varchar,
	"target_document_title" varchar,
	"target_issue_date" timestamp with time zone,
	"target_eff_from" timestamp with time zone,
	"target_status" varchar,
	"reference_type" bigint,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_references__dlt_id_key" UNIQUE
);
CREATE TABLE "document_related_files" (
	"id" varchar NOT NULL,
	"document_id" varchar,
	"file_name" varchar,
	"related_type" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_related_files__dlt_id_key" UNIQUE,
	"file_title" varchar,
	"file_order" bigint
);
CREATE TABLE "document_state" (
	"workflow_id" bigint,
	"item_id" varchar,
	"start_time" timestamp with time zone,
	"end_time" timestamp with time zone,
	"workflow_version" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_state__dlt_id_key" UNIQUE
);
CREATE TABLE "document_summary" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"md_hash" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_summary__dlt_id_key" UNIQUE
);
CREATE TABLE "document_total" (
	"update_at" timestamp with time zone,
	"total_count" bigint,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_total__dlt_id_key" UNIQUE
);
CREATE TABLE "documents" (
	"item_id" varchar NOT NULL,
	"title" varchar,
	"doc_num" varchar,
	"doc_type_id" varchar,
	"eff_status_id" varchar,
	"issue_date" timestamp with time zone,
	"eff_from" timestamp with time zone,
	"updated_date" timestamp with time zone,
	"is_new" boolean,
	"is_lw" boolean,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "documents__dlt_id_key" UNIQUE,
	"eff_to" timestamp with time zone,
	"source_document_id" varchar,
	"has_original_pdf" boolean,
	"lang" varchar,
	"review_status" varchar,
	"drive_id" varchar,
	"view_count" bigint,
	"document_content_file_name" varchar,
	"is_old" boolean,
	"is_effect_all_document" boolean,
	"has_content" boolean,
	"has_ai_processed" boolean,
	"agency_name" varchar,
	"status" varchar,
	"document_content_file_doc_name" varchar
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
CREATE TABLE "workflows" (
	"id" bigint,
	"code" varchar,
	"description" varchar,
	"workflow_version" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "workflows__dlt_id_key" UNIQUE,
	"parent_id" bigint
);
CREATE TABLE "public_staging"."_dlt_version" (
	"version" bigint NOT NULL,
	"engine_version" bigint NOT NULL,
	"inserted_at" timestamp with time zone NOT NULL,
	"schema_name" varchar NOT NULL,
	"version_hash" varchar NOT NULL,
	"schema" varchar NOT NULL
);
CREATE TABLE "public_staging"."dim_doc_type" (
	"id" varchar NOT NULL,
	"code" varchar,
	"name" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "dim_doc_type__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."dim_eff_status" (
	"id" varchar NOT NULL,
	"code" varchar,
	"name" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "dim_eff_status__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."dim_major" (
	"id" varchar NOT NULL,
	"code" varchar,
	"name" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "dim_major__dlt_id_key" UNIQUE,
	"short_name" varchar
);
CREATE TABLE "public_staging"."document_chunking" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"md_hash" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_chunking__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_context" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"summary_md5" varchar,
	"chunk_md5" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_context__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_embedding" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"context_md5" varchar,
	"vector_count" bigint,
	"status" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_embedding__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_issues" (
	"id" varchar NOT NULL,
	"document_id" varchar,
	"agency_id" varchar,
	"agency_name" varchar,
	"person_id" varchar,
	"person_name" varchar,
	"job_title_code" varchar,
	"job_title_name" varchar,
	"order_index" bigint,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_issues__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_majors" (
	"document_id" varchar NOT NULL,
	"major_id" varchar NOT NULL,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_majors__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_markdown" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_markdown__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_references" (
	"id" varchar NOT NULL,
	"document_id" varchar,
	"target_document_id" varchar,
	"target_document_type" varchar,
	"target_document_num" varchar,
	"target_document_title" varchar,
	"target_issue_date" timestamp with time zone,
	"target_eff_from" timestamp with time zone,
	"target_status" varchar,
	"reference_type" bigint,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_references__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_related_files" (
	"id" varchar NOT NULL,
	"document_id" varchar,
	"file_name" varchar,
	"related_type" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_related_files__dlt_id_key" UNIQUE,
	"file_title" varchar,
	"file_order" bigint
);
CREATE TABLE "public_staging"."document_state" (
	"workflow_id" bigint,
	"item_id" varchar,
	"start_time" timestamp with time zone,
	"end_time" timestamp with time zone,
	"workflow_version" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_state__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."document_summary" (
	"item_id" varchar NOT NULL,
	"update_at" timestamp with time zone,
	"drive_id" varchar,
	"md_hash" varchar,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "document_summary__dlt_id_key" UNIQUE
);
CREATE TABLE "public_staging"."documents" (
	"item_id" varchar NOT NULL,
	"title" varchar,
	"doc_num" varchar,
	"doc_type_id" varchar,
	"eff_status_id" varchar,
	"issue_date" timestamp with time zone,
	"eff_from" timestamp with time zone,
	"updated_date" timestamp with time zone,
	"is_new" boolean,
	"is_lw" boolean,
	"_dlt_load_id" varchar NOT NULL,
	"_dlt_id" varchar NOT NULL CONSTRAINT "documents__dlt_id_key" UNIQUE,
	"eff_to" timestamp with time zone,
	"source_document_id" varchar,
	"has_original_pdf" boolean,
	"lang" varchar,
	"review_status" varchar,
	"drive_id" varchar,
	"view_count" bigint,
	"document_content_file_name" varchar,
	"is_old" boolean,
	"is_effect_all_document" boolean,
	"has_content" boolean,
	"has_ai_processed" boolean,
	"agency_name" varchar,
	"status" varchar,
	"document_content_file_doc_name" varchar
);
CREATE UNIQUE INDEX "_dlt_pipeline_state__dlt_id_key" ON "_dlt_pipeline_state" ("_dlt_id");
CREATE UNIQUE INDEX "alembic_version_pkc" ON "alembic_version" ("version_num");
CREATE UNIQUE INDEX "dim_doc_type__dlt_id_key" ON "dim_doc_type" ("_dlt_id");
CREATE UNIQUE INDEX "dim_eff_status__dlt_id_key" ON "dim_eff_status" ("_dlt_id");
CREATE UNIQUE INDEX "dim_major__dlt_id_key" ON "dim_major" ("_dlt_id");
CREATE UNIQUE INDEX "document_chunking__dlt_id_key" ON "document_chunking" ("_dlt_id");
CREATE UNIQUE INDEX "document_context__dlt_id_key" ON "document_context" ("_dlt_id");
CREATE UNIQUE INDEX "document_embedding__dlt_id_key" ON "document_embedding" ("_dlt_id");
CREATE UNIQUE INDEX "document_issues__dlt_id_key" ON "document_issues" ("_dlt_id");
CREATE UNIQUE INDEX "document_majors__dlt_id_key" ON "document_majors" ("_dlt_id");
CREATE UNIQUE INDEX "document_markdown__dlt_id_key" ON "document_markdown" ("_dlt_id");
CREATE UNIQUE INDEX "document_references__dlt_id_key" ON "document_references" ("_dlt_id");
CREATE UNIQUE INDEX "document_related_files__dlt_id_key" ON "document_related_files" ("_dlt_id");
CREATE UNIQUE INDEX "document_state__dlt_id_key" ON "document_state" ("_dlt_id");
CREATE UNIQUE INDEX "document_summary__dlt_id_key" ON "document_summary" ("_dlt_id");
CREATE UNIQUE INDEX "document_total__dlt_id_key" ON "document_total" ("_dlt_id");
CREATE UNIQUE INDEX "documents__dlt_id_key" ON "documents" ("_dlt_id");
CREATE INDEX "ix_request_logs_id" ON "request_logs" ("id");
CREATE INDEX "ix_request_logs_request_id" ON "request_logs" ("request_id");
CREATE UNIQUE INDEX "request_logs_pkey" ON "request_logs" ("id");
CREATE UNIQUE INDEX "workflows__dlt_id_key" ON "workflows" ("_dlt_id");
CREATE UNIQUE INDEX "dim_doc_type__dlt_id_key" ON "public_staging"."dim_doc_type" ("_dlt_id");
CREATE UNIQUE INDEX "dim_eff_status__dlt_id_key" ON "public_staging"."dim_eff_status" ("_dlt_id");
CREATE UNIQUE INDEX "dim_major__dlt_id_key" ON "public_staging"."dim_major" ("_dlt_id");
CREATE UNIQUE INDEX "document_chunking__dlt_id_key" ON "public_staging"."document_chunking" ("_dlt_id");
CREATE UNIQUE INDEX "document_context__dlt_id_key" ON "public_staging"."document_context" ("_dlt_id");
CREATE UNIQUE INDEX "document_embedding__dlt_id_key" ON "public_staging"."document_embedding" ("_dlt_id");
CREATE UNIQUE INDEX "document_issues__dlt_id_key" ON "public_staging"."document_issues" ("_dlt_id");
CREATE UNIQUE INDEX "document_majors__dlt_id_key" ON "public_staging"."document_majors" ("_dlt_id");
CREATE UNIQUE INDEX "document_markdown__dlt_id_key" ON "public_staging"."document_markdown" ("_dlt_id");
CREATE UNIQUE INDEX "document_references__dlt_id_key" ON "public_staging"."document_references" ("_dlt_id");
CREATE UNIQUE INDEX "document_related_files__dlt_id_key" ON "public_staging"."document_related_files" ("_dlt_id");
CREATE UNIQUE INDEX "document_state__dlt_id_key" ON "public_staging"."document_state" ("_dlt_id");
CREATE UNIQUE INDEX "document_summary__dlt_id_key" ON "public_staging"."document_summary" ("_dlt_id");
CREATE UNIQUE INDEX "documents__dlt_id_key" ON "public_staging"."documents" ("_dlt_id");
