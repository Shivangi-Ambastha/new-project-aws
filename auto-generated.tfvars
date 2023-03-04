#this is auto generate file 
#do not check-in to source repo 


prefix_list_names =["fb_private_gateways", "fb_vpc_connect_gateways", "fb_public_gateways", "imperva_ipv4_ips", "imperva_ipv6_ips", "sg_outbound_public"] 

prefix_list_ids =["pl-010687b01aa3c68da", "pl-054e506ddd8985b34", "pl-0f6c311b3632cc159", "pl-09a03cd1dd60d3567", "pl-0afcd0768406b26cb", "pl-0a8811d792af96bd2"] 

fb_internal_gw_prefixlist =["10.0.0.0/16", "10.0.1.0/24"] 

fb_public_gw_prefixlist =["10.0.2.0/24"] 

imperva_prefixlist =["10.0.3.0/24", "10.0.4.0/24"] 

egress_control_prefixlist =["0.0.0.0/0"] 

fb_tfstate_region ="us-east-2" 
fb_primary_region ="us-east-2" 
fb_dr_region ="us-west-1" 
fb_secrets_region ="us-east-2" 
account_statefile_s3_bucket ="fb-tfstate-npd-account-arunvel1988" 
statefile_key ="terraform/states/terraform.tfstate" 
account_workspace ="dev-account" 
