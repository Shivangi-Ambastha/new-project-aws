import boto3
import HttpHelper as httpHelper


def deleteLogGroups(primary_region: str, name_prefixes: list):
    max_results = 10
    env_log_groups = []
    

    client = boto3.client('logs', region_name=primary_region)

    for name_prefix in name_prefixes:
        print("Prefix: {0}".format(name_prefix))
        fetch_next = True
        nextToken = ''
        # get all buckets list
        while fetch_next:
            response = None

            if len(nextToken) > 0:
                response = client.describe_log_groups(
                    limit=max_results,
                    nextToken=nextToken
                )
            else:
                response = client.describe_log_groups(
                    limit=max_results
                )
                        
            # get all the environment specific buckets
            if httpHelper.getResponseCode(response) == 200 and len(response['logGroups']) > 0:
                for logGroup in response['logGroups']:
                    log_grp_name = logGroup['logGroupName']

                    if (log_grp_name.find(name_prefix) >= 0) and (log_grp_name not in env_log_groups):
                        env_log_groups.append(log_grp_name)

                # get next token
                nextToken = response['nextToken'] if 'nextToken' in response else ''
                fetch_next = len(nextToken) > 0

    # delete the cloudwatch log groups
    if len(env_log_groups) > 0:
        print("Delete the environment specific Cloudwatch log groups: {0}".format(
            ",".join(env_log_groups)))

        for log_grp_name in env_log_groups:
            response = client.delete_log_group(logGroupName=log_grp_name)

            if httpHelper.getResponseCode(response) == 200:
                print("Destroyed Cloudwatch log group: {0}".format(
                    log_grp_name))

