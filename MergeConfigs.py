import json
from jsonmerge import merge
import TFFileHelper as tffile

# to merge environment specific tfvars and common tfvars file
# env_config_file       -   environment specific tfvars file like dev1.tfvars.json
# common_config_file    -   environment specific common tfvars file like dev-common.tfvars.json
# merge_file_to_create  -   merge tfvar file to create based on common tfvars file
def mergeConfigs(env_config_file: str, common_config_file: str, merge_file_to_create: str):
    # delete the merged tfvar file
    if tffile.isFileExists(merge_file_to_create):
        tffile.deleteIfExists(merge_file_to_create)
    
    #get the common configuration
    common_config = tffile.getJsonData(common_config_file)
    #get the environment configuration
    if not common_config is None:
        env_config = tffile.getJsonData(env_config_file)
        #merge the configs
        merged_data = merge(common_config, env_config)        
        #write to the merged config file
        tffile.writeJson(merge_file_to_create, merged_data)

