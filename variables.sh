

export PROJECT_ID_GOV="cdmc-gov-labs"
export PROJECT_ID_DATA="cdmc-confdata-labs"
export REGION="us-central1"
export TAG_ENGINE_PROJECT=$PROJECT_ID_GOV
export TAG_ENGINE_URL=`gcloud run services describe tag-engine-api --format="value(status.url)"`
export TAG_ENGINE_SA="cloud-run@$PROJECT_ID_GOV.iam.gserviceaccount.com"     # email of your Cloud Run service account for running Tag Engine service
export TAG_CREATOR_SA="tag-creator@$PROJECT_ID_GOV.iam.gserviceaccount.com"


echo $PROJECT_ID_GOV
echo $PROJECT_ID_DATA
echo $REGION
echo "tag engine project =" $TAG_ENGINE_PROJECT
echo "tag engine URL" $TAG_ENGINE_URL
echo "tag engine SA" $TAG_ENGINE_SA
echo "tag creator SA" $TAG_CREATOR_SA