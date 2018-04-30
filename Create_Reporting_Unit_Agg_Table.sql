DROP TABLE IF EXISTS "WADE"."REPORTING_UNIT_AGG"

CREATE TABLE "WADE"."REPORTING_UNIT_AGG"(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier for the organization.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the reporting organization.
  "REPORTING_UNIT_NAME" character varying(240) NOT NULL, -- Name of the reporting unit.
  "LEVEL_2_REPORTING_UNIT_NAME" character varying(240), -- Name of level 2 (aggregated) reporting unit
  "LEVEL_2_REPORTING_UNIT_ID" character varying(35), -- A unique identifier assigned to the level 2 reporting unit
  "LEVEL_3_REPORTING_UNIT_NAME" character varying(240), -- Name of level 3 (aggregated level 2) reporting unit
  "LEVEL_3_REPORTING_UNIT_ID" character(35), -- A unique identifier assigned to the level 2 reporting unit
   CONSTRAINT "PK_REPORTING_UNIT_AGG" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_UNIT_ID"));


