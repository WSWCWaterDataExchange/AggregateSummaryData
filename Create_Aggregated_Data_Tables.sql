DROP TABLE IF EXISTS "TEMP_AGG_LEVEL_2";
DROP TABLE IF EXISTS "TEMP_AGG_LEVEL_3";

--Copy spatial unit information into table from csv using \COPY "WADE"."REPORTING_UNIT_AGG" FROM 'C:\Users\Carly\Desktop\CADatabase\CASpatialUnits_Formatted.csv' DELIMITER ',' CSV HEADER NULL ''

--Add Level 2 information
SELECT 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "REPORTING_UNIT_AGG"."LEVEL_2_REPORTING_UNIT_ID" AS "REPORT_UNIT_ID",
  "REPORTING_UNIT_AGG"."LEVEL_2_REPORTING_UNIT_NAME" AS "REPORTING_UNIT_NAME"
INTO "TEMP_AGG_LEVEL_2"
FROM 
  "WADE"."REPORTING_UNIT_AGG"
GROUP BY 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "REPORTING_UNIT_AGG"."LEVEL_2_REPORTING_UNIT_ID",  
  "REPORTING_UNIT_AGG"."LEVEL_2_REPORTING_UNIT_NAME"  
ORDER BY "LEVEL_2_REPORTING_UNIT_ID";

ALTER TABLE "TEMP_AGG_LEVEL_2" 
	ADD COLUMN "REPORT_ID" character varying(35) DEFAULT '2010',
	ADD COLUMN "REPORTING_UNIT_TYPE" character varying(35) DEFAULT 'Planning Area',
	ADD COLUMN "STATE" numeric(18,0) DEFAULT 49,
	ADD COLUMN "COUNTY_FIPS" character(5),
	ADD COLUMN "HUC" character varying(12);

INSERT INTO "WADE"."REPORTING_UNIT" SELECT "ORGANIZATION_ID","REPORT_ID",
"REPORT_UNIT_ID","REPORTING_UNIT_NAME","REPORTING_UNIT_TYPE","STATE",
"COUNTY_FIPS","HUC" FROM "TEMP_AGG_LEVEL_2";

--Add Level 3 information
SELECT 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID" AS "REPORT_UNIT_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_NAME" AS "REPORTING_UNIT_NAME"
INTO "TEMP_AGG_LEVEL_3"
FROM 
  "WADE"."REPORTING_UNIT_AGG"
GROUP BY 
  "REPORTING_UNIT_AGG"."ORGANIZATION_ID",
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_ID",  
  "REPORTING_UNIT_AGG"."LEVEL_3_REPORTING_UNIT_NAME"  
ORDER BY "LEVEL_3_REPORTING_UNIT_ID";

ALTER TABLE "TEMP_AGG_LEVEL_3" 
	ADD COLUMN "REPORT_ID" character varying(35) DEFAULT '2010',
	ADD COLUMN "REPORTING_UNIT_TYPE" character varying(35) DEFAULT 'Hydrologic Region',
	ADD COLUMN "STATE" numeric(18,0) DEFAULT 49,
	ADD COLUMN "COUNTY_FIPS" character(5),
	ADD COLUMN "HUC" character varying(12);

INSERT INTO "WADE"."REPORTING_UNIT" SELECT "ORGANIZATION_ID","REPORT_ID",
"REPORT_UNIT_ID","REPORTING_UNIT_NAME","REPORTING_UNIT_TYPE","STATE",
"COUNTY_FIPS","HUC" FROM "TEMP_AGG_LEVEL_3";