CREATE OR REPLACE FUNCTION `cdmc-gov-labs.remote_functions`.get_bytes_transferred(mode STRING,
											project STRING, dataset STRING, table STRING) RETURNS FLOAT64
REMOTE WITH CONNECTION `cdmc-gov-labs.us-central1.remote-function-connection`
OPTIONS
(endpoint = 'https://us-central1-cdmc-gov-labs.cloudfunctions.net/get_bytes_transferred'
);