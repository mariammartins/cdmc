from google.cloud import bigquery
from google.api_core.exceptions import NotFound

def create_dataset(bq_client, dataset_id, region):
    dataset_ref = bigquery.Dataset(bq_client.dataset(dataset_id))
    dataset_ref.location = region
    try:
        bq_client.get_dataset(dataset_ref)
        print(f'Dataset {dataset_id} already exists')
    except NotFound:
        bq_client.create_dataset(dataset_ref)
        print(f'Created dataset {dataset_id} in {region}')

def copy_permissions(old_dataset_id, new_dataset_id, bq_client):
    old_dataset = bq_client.get_dataset(old_dataset_id)
    new_dataset = bq_client.get_dataset(new_dataset_id)

    new_dataset.access_entries = old_dataset.access_entries
    bq_client.update_dataset(new_dataset, ["access_entries"])
    print(f'Copied permissions from {old_dataset_id} to {new_dataset_id}')

def copy_tables(old_dataset_id, new_dataset_id, bq_client):
    tables = bq_client.list_tables(old_dataset_id)
    for table in tables:
        old_table_ref = bq_client.dataset(old_dataset_id).table(table.table_id)
        new_table_ref = bq_client.dataset(new_dataset_id).table(table.table_id)

        job = bq_client.copy_table(old_table_ref, new_table_ref)
        job.result()
        print(f'Copied table {table.table_id} from {old_dataset_id} to {new_dataset_id}')

def delete_dataset(dataset_id, bq_client):
    bq_client.delete_dataset(dataset_id, delete_contents=True, not_found_ok=True)
    print(f'Deleted dataset {dataset_id}')

def rename_dataset(old_dataset_id, new_dataset_id, region, bq_client):
    create_dataset(bq_client, new_dataset_id, region)
    copy_permissions(old_dataset_id, new_dataset_id, bq_client)
    copy_tables(old_dataset_id, new_dataset_id, bq_client)
    delete_dataset(old_dataset_id, bq_client)

if __name__ == '__main__':
    bq_client = bigquery.Client()
    old_dataset_id = 'finwire_dlp_copy'
    new_dataset_id = 'finwire_dlp'
    region = 'us-central1'

    rename_dataset(old_dataset_id, new_dataset_id, region, bq_client)
