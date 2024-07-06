CREATE OR REPLACE FUNCTION `cdmc-gov-labs.remote_functions`.get_masking_rule(mode STRING,
											project STRING, dataset STRING, table STRING) RETURNS STRING
REMOTE WITH CONNECTION `cdmc-gov-labs.us-central1.remote-function-connection`
OPTIONS
(endpoint = 'https://us-central1-cdmc-gov-labs.cloudfunctions.net/get_masking_rule'
);