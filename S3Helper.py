import boto3
import HttpHelper as httpHelper
import TFFileHelper as tffile

def deleteBuckets(primary_region: str, name_prefix: str):
    max_results = 1000    
    env_buckets = []
    
    client = boto3.client('s3', region_name=primary_region)
    #get all buckets list
    response = client.list_buckets()
    
    #get all the environment specific buckets
    if httpHelper.getResponseCode(response) == 200 and len(response['Buckets']) > 0:
        for bucket in response['Buckets']: 
            bucket_name = bucket['Name']
            if bucket_name.startswith(name_prefix):
                env_buckets.append(bucket_name)

    #delete all the environment buckets
    if len(env_buckets) > 0:
        print("Destroying the environment buckets: {0}".format(",".join(env_buckets)))
        s3 = boto3.resource('s3')

        for bucket_name in env_buckets:
            bucket = s3.Bucket(bucket_name)
            bucket.object_versions.delete()
            bucket.objects.all().delete()
            bucket.delete()

        print("Destroyed the environmentspecific buckets")