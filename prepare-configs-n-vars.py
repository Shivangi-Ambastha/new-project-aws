import json
import os
import sys
import argparse
sys.path.append('./../tfscripts')
from Utils import Constants
import TFConfigJPathQueries as tfjpq
import CommonConfigs as ccfg
from entities import JPathQuery as jpq
import TFFileHelper as tffile
import TFConfig2Vars as cfg2vars
import BackendConfig as backend
import PrefixLists as prefix
import TFJsonHelper as tfjson


def ValidateInputValue(val, error_message):
    # input can not be empty
    if val is None or len(val) == 0:
        print(error_message)
        exit(1)


# validate input arguments
def ValidateInputArgs(args):
    config_file = args.config
    acct_workspace = args.acct
    vpc_workspace = args.vpc

    # validate file name input
    ValidateInputValue(config_file, Constants.arguments_error_message)
    ValidateInputValue(acct_workspace, Constants.arguments_error_message)
    ValidateInputValue(vpc_workspace, Constants.arguments_error_message)

    # validate if config file exists
    file_path = Constants.fb_terraform_config_format.format(config_file)
    if not tffile.isFileExists(file_path):
        print(Constants.config_file_error.format(file_path))
        exit(1)

    # validate if account workspace exists in config file
    workspace = ccfg.getAccountWorkspaceName(file_path, acct_workspace)
    if workspace is None or (str(workspace) != acct_workspace):
        print(Constants.workspace_name_invalid_msg.format(
            "Account", acct_workspace))
        exit(1)

    # validate if vpc workspace exists in config file
    workspace = ccfg.getVPCWorkspaceName(
        file_path, acct_workspace, vpc_workspace)
    if workspace is None or (str(workspace) != vpc_workspace):
        print(Constants.workspace_name_invalid_msg.format("VPC", vpc_workspace))
        exit(1)


# main
def main():
    # constants
    # read the arguments
    arg_parser = argparse.ArgumentParser(
        description=Constants.prog_description)
    arg_parser.add_argument('-a', '--acct', type=str,
                            help='Account workspace name')
    arg_parser.add_argument('-v', '--vpc', type=str, help='VPC workspace name')
    arg_parser.add_argument('-c', '--config', type=str,
                            help='TF Config file name')
    args = arg_parser.parse_args()

    # validate the input arguments
    ValidateInputArgs(args)
    acct_workspace = args.acct
    vpc_workspace = args.vpc
    fb_terraform_config = Constants.fb_terraform_config_format.format(
        args.config)

    print("Requested account workspace {0}".format(acct_workspace))
    env_specific_tfvars_file = Constants.env_specific_tfvars_file.format(
        vpc_workspace)
    primary_region = ccfg.getVPCPrimaryRegion(
        fb_terraform_config, acct_workspace, vpc_workspace)
    print("VPC primary region is {0}".format(primary_region))

    # *** HCL file - backend config ***
    # delete the auto-generated hcl file
    tffile.deleteAndCreateEmpty(Constants.auto_gen_hcl_file)

    print("* Start - Auto-Generate the back-config HCL file *")
    queries = tfjpq.getBackendConfigQueries(acct_workspace, vpc_workspace)
    backend.prepare(fb_terraform_config, Constants.auto_gen_hcl_file, queries)
    print("* End - Auto-Generate the back-config HCL file *\n")

    # *** VAR file ***
    # delete the auto-generated tfvars file
    tffile.deleteAndCreateEmpty(Constants.auto_gen_tfvars_file)

    # fetch VPC managed prefix list
    print("* Start - Write VPC Managed Prefix Lists - CIDRs to VARS file *")
    prefix_query = tfjpq.getPrefixListQuery()
    managed_prefix_json_data = tfjson.getValue(
        env_specific_tfvars_file, prefix_query).value
    prefix.prepare(primary_region, Constants.auto_gen_tfvars_file,
                   managed_prefix_json_data)
    print("* End - Write VPC Managed Prefix Lists - CIDRs to VARS file *\n")

    # prepare VARs from the fb_terraform_config json
    print("* Start - Fetch and Write VARs from terraform config json *")
    cfg2vars_query = tfjpq.getTFConfig2VarsQueries(acct_workspace, vpc_workspace)
    cfg2vars.prepare(fb_terraform_config,
                     Constants.auto_gen_tfvars_file, cfg2vars_query)
    print("* End - Fetch and Write VARs from terraform config json * \n")

if __name__ == "__main__":
    main()
