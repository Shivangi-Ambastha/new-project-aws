import boto3
import json
import HttpHelper as httpHelper
import TFFileHelper as tffile

def prepare(primary_region: str, auto_gen_tfvars_file: str, prefix_list_keys: dict):
    max_results = 100    
    prefix_list_cidrs = {}
    all_prefix_list_ids = {}

    #ec2 client
    client = boto3.client('ec2', region_name=primary_region)    

    for prefix_list_key in prefix_list_keys:
        cidr_list = []
        prefix_list_ids = {}

        if len(prefix_list_keys[prefix_list_key]) > 0:
            #get the managed prefix list IDs
            prefix_list_names = prefix_list_keys[prefix_list_key]
            response = client.describe_managed_prefix_lists(
                Filters=[{'Name': 'prefix-list-name','Values': prefix_list_names}],
                MaxResults=max_results
                )

            #read the reponse
            if httpHelper.getResponseCode(response) == 200 and len(response['PrefixLists']) > 0:
                for prefix_list in response['PrefixLists']:
                    prefix_list_arn     = prefix_list['PrefixListArn']
                    prefix_list_name    = prefix_list['PrefixListName']
                    prefix_list_id      = prefix_list_arn[prefix_list_arn.rindex("/")+1:]
                    prefix_list_ids[prefix_list_name] = prefix_list_id
                    all_prefix_list_ids[prefix_list_name] = prefix_list_id
            else:
                print("No prefix-lists exist with names: "+json.dumps(prefix_list_names))

            
            #prepare the prefix-list CIDRs
            for prefix_name in prefix_list_ids:
                prefix_list_id = prefix_list_ids[prefix_name]

                response = client.get_managed_prefix_list_entries(PrefixListId=prefix_list_id,MaxResults=max_results)
                if httpHelper.getResponseCode(response) == 200 and len(response['Entries']) > 0:                
                    for cidr_entry in response['Entries']:
                        cidr_list.append(cidr_entry['Cidr'])   
                else:
                    print("No CIDRs listed for : "+ prefix_name + " : " + prefix_list_id)

            #prepare the prefix-list cidrs mapping
            prefix_list_cidrs[prefix_list_key] = cidr_list       


    # write prefix names, ids
    if len(all_prefix_list_ids) > 0:
        tffile.appendArray(auto_gen_tfvars_file, "prefix_list_names", list(all_prefix_list_ids.keys()))
        tffile.appendArray(auto_gen_tfvars_file, "prefix_list_ids", list(all_prefix_list_ids.values()))
    
    #write to auto-generate TFVARS file
    if len(prefix_list_cidrs) > 0:
        for prefix_name in prefix_list_cidrs:
            tffile.appendArray(auto_gen_tfvars_file, prefix_name, prefix_list_cidrs[prefix_name])
