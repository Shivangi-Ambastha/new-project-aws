import boto3
import TFFileHelper as tffile
import TFJsonHelper as tfjson
from entities import JPathQuery as jpq

def prepare(fb_terraform_config: str, auto_gen_hcl_file: str, queries: dict):
    vals = tfjson.getValues(fb_terraform_config, queries)

    encryptObj = jpq.JPathQuery("encrypt", '', False, False)
    encryptObj.value = "true"
    encryptObj.jsonDumpRequired = False
    vals.append(encryptObj)    
    
    tffile.appendJPathValues(auto_gen_hcl_file, vals)

