#!/bin/bash
#help   https://www.shellscript.sh/tips/getopts/

source ./../tfscripts/common_automation_functions.sh
usage()
{
  echo -e "Usage: $0
                  [-A   Account Workspace]
                  [-V   Network/VPC Workspace]
                  [-a   For terraform refresh, plan, apply and destroy actions ]"
  exit 2
}

#######################
# Main script starts here

#first, clear all the variables
unset FB_TF_CONFIG_PATH FB_TF_ACTION FB_ACCT_WORKSPACE FB_VPC_WORKSPACE

while getopts 'A:V:a:?h' c
do
  case $c in
    A) set_variable FB_ACCT_WORKSPACE $OPTARG ;;
    V) set_variable FB_VPC_WORKSPACE $OPTARG ;;
    a) set_variable FB_TF_ACTION $OPTARG ;;
    h|?) usage ;; esac
done

# identify the config file based on the environment
set_config_file $FB_ACCT_WORKSPACE FB_TF_CONFIG_PATH

#[ -z "$FB_ACCT_WORKSPACE" ] && usage
#[ -z "$FB_VPC_WORKSPACE" ] && usage
#[ -z "$FB_TF_CONFIG_PATH" ] && usage
#[ -z "$FB_TF_ACTION" ] && usage

validate_input_var $FB_ACCT_WORKSPACE
validate_input_var $FB_VPC_WORKSPACE
validate_input_var $FB_TF_CONFIG_PATH
validate_input_var $FB_TF_ACTION

echo "Account workspace     : " $FB_ACCT_WORKSPACE
echo "VPC workspace         : " $FB_VPC_WORKSPACE
echo "Terraform config file : " $FB_TF_CONFIG_PATH
echo "Terraform action      : " $FB_TF_ACTION

#validate pre-requistes
validate_prerequisites

# auto-genarate backend-config and some of the vars
echo -e " \n *** Auto-genarate backend-config and some of the variable values \n "
python3 -B "./scripts/prepare-configs-n-vars.py" -a=$FB_ACCT_WORKSPACE -v=$FB_VPC_WORKSPACE -c=$FB_TF_CONFIG_PATH

#initialize the workspace
tf_init_workspace $FB_VPC_WORKSPACE

# validate terraform scripts and perform action
tf_validate_and_execute $FB_VPC_WORKSPACE $FB_TF_ACTION
