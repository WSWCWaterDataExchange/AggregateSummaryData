# AggregateSummaryData
Aggregates data at multiple spatial scales


These scripts were created to aggregate summary use data for California at 3 different scales (Detailed Analysis Units - Planning Areas - Hydrologic Regions). The scripts could be adapted for other datatypes, different levels, or states with some modifications.

## Workflow
1. Create the aggregated reporting unit table (Create_Reporting_Unit_Agg_Table.sql)
2. Load the "mapped" aggregated units (\COPY "WADE"."REPORTING_UNIT_AGG" FROM '~/CASpatialUnits_Formatted.csv' DELIMITER ',' CSV HEADER NULL '')
3. Calculate aggregated amounts for each level, and add these new amounts to the table (Level2Aggregation_AMOUNT.sql, Level3Aggregation_AMOUNT.sql)
