﻿DROP TABLE IF EXISTS "TEMP_LEVEL_3_SUMMARY_USE";
DROP TABLE IF EXISTS "TEMP_LEVEL_3_S_USE_AMOUNT";
--Add aggregated reporting unit information to SUMMARY_USE TABLE
SELECT 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "S_USE_AMOUNT"."REPORT_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID" AS "REPORT_UNIT_ID",
  "S_USE_AMOUNT"."BENEFICIAL_USE_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID" AS "WFS_FEATURE_REF"
INTO "TEMP_LEVEL_3_SUMMARY_USE"
FROM 
  "WADE"."S_USE_AMOUNT", 
  "WADE"."REPORTING_UNIT_AGG"
WHERE 
  "S_USE_AMOUNT"."REPORT_UNIT_ID" = "REPORTING_UNIT_AGG"."REPORT_UNIT_ID"
GROUP BY 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "S_USE_AMOUNT"."REPORT_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID",  
  "S_USE_AMOUNT"."BENEFICIAL_USE_ID"
ORDER BY "LEVEL_3_REPORTING_UNIT_ID";

ALTER TABLE "TEMP_LEVEL_3_SUMMARY_USE" 
	ADD COLUMN "SUMMARY_SEQ" numeric(18,0) DEFAULT 1,
	ADD COLUMN "FRESH_SALINE_IND" numeric(18,0) DEFAULT 1,
	ADD COLUMN "SOURCE_TYPE" numeric(18,0) DEFAULT 1,
	ADD COLUMN "POWER_GENERATED" numeric(18,3) DEFAULT -999.000,
	ADD COLUMN "POPULATION_SERVED" numeric(18,3) DEFAULT -999.000;

INSERT INTO "WADE"."SUMMARY_USE" SELECT "ORGANIZATION_ID","REPORT_ID",
"REPORT_UNIT_ID","SUMMARY_SEQ","BENEFICIAL_USE_ID","FRESH_SALINE_IND","SOURCE_TYPE",
"POWER_GENERATED","POPULATION_SERVED" FROM "TEMP_LEVEL_3_SUMMARY_USE";


--Add aggregated amount information to S_USE_AMOUNT TABLE
SELECT 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "S_USE_AMOUNT"."REPORT_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID" AS "REPORT_UNIT_ID",
  "S_USE_AMOUNT"."BENEFICIAL_USE_ID", 
  SUM("S_USE_AMOUNT"."AMOUNT") AS "AMOUNT",
  "S_USE_AMOUNT"."CONSUMPTIVE_INDICATOR",
  "S_USE_AMOUNT"."METHOD_ID",
  "S_USE_AMOUNT"."START_DATE",
  "S_USE_AMOUNT"."END_DATE"
INTO "TEMP_LEVEL_3_S_USE_AMOUNT"
FROM 
  "WADE"."S_USE_AMOUNT", 
  "WADE"."REPORTING_UNIT_AGG"
WHERE 
  "S_USE_AMOUNT"."REPORT_UNIT_ID" = "REPORTING_UNIT_AGG"."REPORT_UNIT_ID"
GROUP BY 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "S_USE_AMOUNT"."REPORT_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID",  
  "S_USE_AMOUNT"."BENEFICIAL_USE_ID",
  "S_USE_AMOUNT"."CONSUMPTIVE_INDICATOR",
  "S_USE_AMOUNT"."METHOD_ID",
  "S_USE_AMOUNT"."START_DATE",
  "S_USE_AMOUNT"."END_DATE"
ORDER BY "LEVEL_3_REPORTING_UNIT_ID";

ALTER TABLE "TEMP_LEVEL_3_S_USE_AMOUNT"
	ADD COLUMN "SUMMARY_SEQ" int DEFAULT 1,
	ADD COLUMN "ROW_SEQ" int DEFAULT 1;

INSERT INTO "WADE"."S_USE_AMOUNT" SELECT "ORGANIZATION_ID","REPORT_ID",
"REPORT_UNIT_ID","BENEFICIAL_USE_ID","SUMMARY_SEQ","ROW_SEQ","AMOUNT",
"CONSUMPTIVE_INDICATOR","METHOD_ID","START_DATE","END_DATE" FROM "TEMP_LEVEL_3_S_USE_AMOUNT";


