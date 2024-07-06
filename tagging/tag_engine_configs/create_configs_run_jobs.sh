# Copyright 2023 Google, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


## This script performs the basic setup tag engine

export TAG_ENGINE_PROJECT=$PROJECT_ID_GOV
export TAG_HISTORY_BIGQUERY_DATASET="tag_history_logs"
gcloud config set project $TAG_ENGINE_PROJECT
gcloud config set run/region $REGION


export TAG_ENGINE_URL=`gcloud run services describe tag-engine-api --format="value(status.url)"`
echo $TAG_ENGINE_URL

# Bearer token
export IAM_TOKEN=$(gcloud auth print-identity-token)

# OAuth TOKEN
#gcloud auth application-default login
export OAUTH_TOKEN=$(gcloud auth application-default print-access-token)

# configure tag history
curl -X POST $TAG_ENGINE_URL/configure_tag_history \
	-d "{"bigquery_region":"$REGION", "bigquery_project":"$PROJECT_ID_GOV", "bigquery_dataset":"$TAG_HISTORY_BIGQUERY_DATASET", "enabled":true}" \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################
# sensitive column tags (controls 6 and 7)
##########################################

# Replace REGION & PROJECT with environment variables in all json template files - REVERSED AT END OF SCRIPT
python3 ../support_functions/replace_string.py tag_engine_configs REGION $REGION .json
python3 ../support_functions/replace_string.py tag_engine_configs PROJECT_ID_GOV $PROJECT_ID_GOV .json
python3 ../support_functions/replace_string.py tag_engine_configs PROJECT_ID_DATA $PROJECT_ID_DATA .json

# crm
curl -X POST $TAG_ENGINE_URL/create_sensitive_column_config \
	-d @tag_engine_configs/data_sensitivity_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"a729caae3a4911ef948d42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"a729caae3a4911ef948d42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"


curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"b4bfb8903a4911efa52942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

  -d '{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"a729caae3a4911ef948d42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

HTTP/2 200
content-type: application/json
x-cloud-trace-context: 9ecf5a83d4089583a944f4041ca12a12;o=1
date: Thu, 04 Jul 2024 21:09:31 GMT
server: Google Frontend
content-length: 48
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

{"job_uuid":"b4bfb8903a4911efa52942004e494300"}

##########################################

# hr
curl -X POST $TAG_ENGINE_URL/create_sensitive_column_config \
	-d @tag_engine_configs/data_sensitivity_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"b9055cba3a4a11ef948d42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"b9055cba3a4a11ef948d42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

HTTP/2 200 
content-type: application/json
x-cloud-trace-context: 7ad2661bf73d84e3e0ddce236fcf50a5;o=1
date: Thu, 04 Jul 2024 21:17:05 GMT
server: Google Frontend
content-length: 48
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

{"job_uuid":"c388add63a4a11ef948d42004e494300"}

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"c388add63a4a11ef948d42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_sensitive_column_config \
	-d @tag_engine_configs/data_sensitivity_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"f04080743a4a11ef9b9342004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"f04080743a4a11ef9b9342004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

HTTP/2 200 
content-type: application/json
x-cloud-trace-context: 7a0e2a99785804f6a331e1f991bf6e43;o=1
date: Thu, 04 Jul 2024 21:18:37 GMT
server: Google Frontend
content-length: 48
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

{"job_uuid":"fa65aa843a4a11ef9b9342004e494300"}

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"fa65aa843a4a11ef9b9342004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# sales
curl -X POST $TAG_ENGINE_URL/create_sensitive_column_config \
	-d @tag_engine_configs/data_sensitivity_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"1727e7e03a4b11ef9b9342004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"1727e7e03a4b11ef9b9342004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

HTTP/2 200 
content-type: application/json
x-cloud-trace-context: 6a9eea975181d165de497106889c7be4;o=1
date: Thu, 04 Jul 2024 21:19:45 GMT
server: Google Frontend
content-length: 48
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

{"job_uuid":"22ed14563a4b11ef9b9342004e494300"}

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"22ed14563a4b11ef9b9342004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_sensitive_column_config \
	-d @tag_engine_configs/data_sensitivity_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"a9d990183a6211efb3b042004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"SENSITIVE_TAG_COLUMN","config_uuid":"a9d990183a6211efb3b042004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

HTTP/2 200
content-type: application/json
x-cloud-trace-context: 4db923ee7fc1c9b156b7f3fdd9ced735;o=1
date: Thu, 04 Jul 2024 21:30:37 GMT
server: Google Frontend
content-length: 48
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

{"job_uuid":"b24f3ac23a6211efb3b042004e494300"}

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"b24f3ac23a6211efb3b042004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"


#########################################
# PAREI AQUI AS 21:09
##########################################

##########################################
# cdmc controls table tags
##########################################

# crm
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cdmc_controls_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"20818e2c3ad211ef9fd742004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"20818e2c3ad211ef9fd742004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"2a7b70aa3ad211ef87d542004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# hr
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cdmc_controls_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"0132252a3ab611efa03742004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"0132252a3ab611efa03742004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"0a4ae1103ab611ef910842004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cdmc_controls_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"634410ac3ab611ef9dc842004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"634410ac3ab611ef9dc842004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"6d6853a43ab611ef910842004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# sales
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cdmc_controls_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"cd2873963ab611ef97bc42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"cd2873963ab611ef97bc42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"d645372a3ab611ef8ec942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cdmc_controls_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"e506d3cc3ab611efae7d42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"e506d3cc3ab611efae7d42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"ef049b203ab611efa03742004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

##########################################
# security policy column tags (control 9)
##########################################

# crm
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/security_policy_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"6f0bfd543ad511efab6542004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"6f0bfd543ad511efab6542004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

{"job_uuid":"45c693763ad211ef955a42004e494300"}

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"81f6be183ad511ef95a942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# hr
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/security_policy_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"51f2ea563ad611efa90e42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"51f2ea563ad611efa90e42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"6020d7783ad611ef895942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/security_policy_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"f60983523ad611ef95a942004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"f60983523ad611ef95a942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"020cf0b23ad711efa90e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# sales
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/security_policy_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"2ac53dac3ad711ef895942004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"2ac53dac3ad711ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"34469d9e3ad711efa90e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/security_policy_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"4c4c13103ad711efa90e42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"4c4c13103ad711efa90e42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"53e3f6ba3ad711ef895942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################
# cost metrics table tags (control 13)
##########################################

# crm
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cost_metrics_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"6d6e4bbc3ad711efba9f42004e494300"}

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"6d6e4bbc3ad711efba9f42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"749089003ad711ef8a8442004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# hr
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cost_metrics_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"81f0d8203ad711ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"8708b3be3ad711efa90e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cost_metrics_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"935e93cc3ad711ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"98a65e283ad711efa90e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# sales
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cost_metrics_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"b571ad003ad711ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"ba6fba0e3ad711efa90e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/cost_metrics_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"ce02023e3ad711ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"d2ec94b23ad711efa90e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################
# completeness column tags (control 12)
##########################################

# crm
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/completeness_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"e9176bc23ad711efba9f42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"ee773e083ad711efba2a42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# hr
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/completeness_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"fc622e103ad711ef911242004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"0322ef503ad811efb6d442004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/completeness_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"14f0a9343ad811ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"19ce84623ad811ef8a8442004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# sales
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/completeness_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"7c4b651a3ad811efba9f42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"81e8e3263ad811ef895942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/completeness_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"93659e963ad811efb6d442004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"9a7a0e7e3ad811ef895942004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################
# correctness column tags (control 12)
##########################################

# crm
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/correctness_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"ba4ffd443ad811efb6d442004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"bf588ba83ad811efba2a42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# hr
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/correctness_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"cc6e1c5e3ad811ef8a8442004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"d196ecce3ad811efba2a42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/correctness_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"de3b4b783ad811ef8a8442004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"e2fd0c283ad811efba2a42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# sales
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/correctness_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"f3e533f83ad811efba9f42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"f87d9e0a3ad811efbed542004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

##########################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_dynamic_column_config \
	-d @tag_engine_configs/correctness_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_COLUMN","config_uuid":"05bba1ca3ad911ef895942004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"0b1daa783ad911ef8a8442004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

#############################################
# impact assessment column tags (control 10)
#############################################

# crm
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/impact_assessment_crm.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"154ca3f03ad911efba9f42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"1a5a6ca63ad911efb52342004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

#############################################

# hr
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/impact_assessment_hr.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"73bf1c5a3adf11efb9a642004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"79660b003adf11ef816b42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

#############################################

# oltp
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/impact_assessment_oltp.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"86b476a23adf11efa60c42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"8df96da03adf11ef816b42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

#############################################

# sales
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/impact_assessment_sales.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"9fc6eabc3adf11ef89be42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"a48447e83adf11ef8a6e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

#############################################

# finwire
curl -X POST $TAG_ENGINE_URL/create_dynamic_table_config \
	-d @tag_engine_configs/impact_assessment_finwire.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"DYNAMIC_TAG_TABLE","config_uuid":"b2574a5a3adf11ef89be42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"b794193a3adf11ef8a6e42004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

###################################################
# export all data catalog tags to bq for reporting
###################################################

curl -X POST $TAG_ENGINE_URL/create_export_config \
	-d @tag_engine_configs/export_all_tags.json \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

curl -i -X POST $TAG_ENGINE_URL/trigger_job \
  -d '{"config_type":"TAG_EXPORT","config_uuid":"5d01f31e3ae111ef815f42004e494300"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

curl -X POST $TAG_ENGINE_URL/get_job_status -d '{"job_uuid":"6cbd0e6a3ae111ef8d2342004e494300"}' \
	-H "Authorization: Bearer $IAM_TOKEN" \
	-H "oauth_token: $OAUTH_TOKEN"

###################################################
# cleanup
###################################################
curl -i -X POST $TAG_ENGINE_URL/purge_inactive_configs \
  -d '{"config_type":"ALL"}' \
  -H "Authorization: Bearer $IAM_TOKEN" \
  -H "oauth_token: $OAUTH_TOKEN"

# Reverse replace REGION & PROJECT with environment variables
python3 ../support_functions/replace_string.py tag_engine_configs $REGION REGION .json
python3 ../support_functions/replace_string.py tag_engine_configs $PROJECT_ID_GOV PROJECT_ID_GOV .json
python3 ../support_functions/replace_string.py tag_engine_configs $PROJECT_ID_DATA PROJECT_ID_DATA .json
