import boto3
import HttpHelper as httpHelper
import TFFileHelper as tffile

def prepare(primary_region: str, auto_gen_tfvars_file: str):
    max_results = 100    
    role_names = []
    role_ids = []

    client = boto3.client('iam', region_name=primary_region)
    #get the managed prefix list IDs
    response = client.list_roles(PathPrefix='/', MaxItems=max_results)
        
    if httpHelper.getResponseCode(response) == 200 and len(response['Roles']) > 0:
        for role in response['Roles']:       
            role_name = role['RoleName']   
        
            #if role_name.startswith("HTS"):
            role_names.append(role_name)
            role_ids.append(role['RoleId'])        
    
    #write to auto-generate TFVARS file
    if len(role_ids) > 0:    
        tffile.appendArray(auto_gen_tfvars_file, "ad_iam_role_names", role_names)
        tffile.appendArray(auto_gen_tfvars_file, "ad_iam_role_ids", role_ids)   