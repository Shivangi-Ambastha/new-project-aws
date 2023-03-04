
# set the variable
set_variable()
{  
  local varname=$1
  #local val_val=$@
  shift
  if [ -z "${!varname}" ]; then    
    eval "$varname=\"$@\""
  else
    echo "Error: $varname already set"
    usage
  fi  
}

validate_input_var()
{
  local default_val="--select--"
  # if the value is default value
  local var_val=$1
  
  if [[ -z "$var_val" ]]; then
    usage
  elif [ $var_val == $default_val ]; then
    usage    
  fi
}

#identify the config file based on the environment
set_config_file()
{
  echo "set_config_file"

  local acct_workspace=$1
  local varname=$2
  shift; shift; 
  local configfile=""
  if [ [acct_workspace == prod*] ]; then
    configfile="tf_prd_acct_config.json"; #for PRODCUTION environment
  else
    configfile="tf_npd_accts_config.json"; #for all NON-PROD environments
  fi
  # set the config variable
  set_variable $varname $configfile
}

# set ECS long ARN format
set_ecs_settings()
{ 
  local region=$1
  shift;
  echo "set_ecs_settings for region: " $region

  aws ecs put-account-setting --name containerInstanceLongArnFormat --value enabled --region $region
  aws ecs put-account-setting --name serviceLongArnFormat           --value enabled --region $region
  aws ecs put-account-setting --name taskLongArnFormat              --value enabled --region $region
}

#validate for python version and install require packages
validate_prerequisites()
{
  echo "validate_prerequisites"
  # require python >=3.9
  # if python has issues use python3
  echo -e " \n *** Validate python version \n "
  python3 -B "./../tfscripts/pre_validation.py"

  # install required python packages
  # if pip has issues use pip3
  echo -e " \n *** Install required python packages \n "
  pip3 install --upgrade --user -r "./../tfscripts/requirements.txt"
}

# initialize the terraform workspace
tf_init_workspace()
{  
  local workspace=$1  
  shift; shift; 

  echo "tf_init_workspace: " $workspace
  # initiatize terraform with backend config file
  echo -e " \n *** Initialize terraform \n "
  terraform init -backend-config="./tfvars/auto-generated.hcl"

  #
  echo -e " \n *** Create/Select the terraform workspace \n "
  terraform workspace select $workspace | terraform workspace new $workspace
}

# validate terraform scrips and perform the action
tf_validate_and_execute()
{
  local workspace=$1
  local action=$2    
  shift; shift;
  local option=""
  local env_tfvar_file="./tfvars/$workspace.tfvars.json"
  local auto_gen_tfvar_file="./tfvars/auto-generated.tfvars"
  local apply_option="apply"

  action=$action  | xargs
  # set optio default as empty  
  if [ $action == $apply_option ]; then
      option="-auto-approve"
  fi

  FILE="./tfvars/$workspace-merged.tfvars.json"
  if [ -f "$FILE" ]; then
      env_tfvar_file=$FILE
      echo "Considering merged tfvars.json file: $FILE"  
  fi
  
  echo "tf_validate_and_execute: " $env_tfvar_file $action $option
  #terraform validate
  echo -e " \n *** Validate terraform scripts \n "
  terraform validate

  # terraform plan
  echo -e " \n *** terraform action with the custom and auto-generated tfvars files \n "
  terraform $action -var-file=$env_tfvar_file -var-file=$auto_gen_tfvar_file $option
  return $?
}
