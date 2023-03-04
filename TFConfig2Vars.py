import boto3
import json
import HttpHelper as httpHelper
import TFFileHelper as tffile
import TFJsonHelper as tfjson
from entities import JPathQuery as jpq

def prepare(fb_terraform_config: str, auto_gen_tfvars_file: str, var_queries_map: dict):
    single_val_dict = {}
    # iterate through the Var and JSON-Keys mapping
    for var_name in var_queries_map:
        queries = var_queries_map[var_name]
        # if it's single query, add it to the dictionary "single_val_dict" and 
        # write the  single_val_dict to the file at the end
        if len(queries) == 1:
            query_val = tfjson.getValue(fb_terraform_config, queries[0])   
            single_val_dict[var_name] = query_val.value
        else:
            query_vals = tfjson.getValues(fb_terraform_config, queries)
            vars_arr = []
            #prepare the vars_arr
            for query_val in query_vals:
                vars_arr.append(query_val.value)            
            #write array to VARs file
            tffile.appendArray(auto_gen_tfvars_file, var_name, vars_arr)

    # write the single values dictionary
    tffile.appendDictionary(auto_gen_tfvars_file, single_val_dict)
