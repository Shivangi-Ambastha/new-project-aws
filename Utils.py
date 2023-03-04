# constants
class Constants:
    prog_description = "Auto-Gen the required Configs and Var files"
    workspace_name_invalid_msg = "{0} workspace does not exists with the name: {1}. Please refer TF config file."
    config_file_error = "config file does not exists: {0}"
    arguments_error_message = "Missing arguments. Run the script with -h for help on required params"
    # FB specific terraform configuration
    fb_terraform_config_format = "./../{0}"
    auto_gen_tfvars_file = "./tfvars/auto-generated.tfvars"  # tfvars file
    auto_gen_hcl_file = "./tfvars/auto-generated.hcl"  # backend config
    # workspace specific tfvar file
    env_specific_tfvars_file = "./tfvars/{0}.tfvars.json"
