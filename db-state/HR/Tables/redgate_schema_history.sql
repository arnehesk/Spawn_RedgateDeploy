CREATE TABLE hr."redgate_schema_history" (
  "installed_rank" NUMBER(*,0) NOT NULL,
  "version" VARCHAR2(50 BYTE),
  "description" VARCHAR2(200 BYTE) NOT NULL,
  "type" VARCHAR2(20 BYTE) NOT NULL,
  "script" VARCHAR2(1000 BYTE) NOT NULL,
  "checksum" NUMBER(*,0),
  "installed_by" VARCHAR2(100 BYTE) NOT NULL,
  "installed_on" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  "execution_time" NUMBER(*,0) NOT NULL,
  "success" NUMBER(1) NOT NULL,
  CONSTRAINT "redgate_schema_history_pk" PRIMARY KEY ("installed_rank")
);