CREATE OR REPLACE FUNCTION `cdmc-gov-labs.remote_functions`.get_ultimate_source(project_id STRING,
						project_num INT64, region STRING, dataset STRING, table STRING) RETURNS STRING
REMOTE WITH CONNECTION `cdmc-gov-labs.us-central1.remote-function-connection`
OPTIONS
(endpoint = 'https://us-central1-cdmc-gov-labs.cloudfunctions.net/get_ultimate_source')
