import sys
sys.path.append('./../tfscripts')
from entities import JPathQuery as jpq


# for BackendConfig (HCL file related)
def getBackendConfigQueries(acct, vpc):
    queries = []
    queries.append(jpq.JPathQuery(
        "key", '$.accounts[?(workspace=="{0}")].tfstate.statefile_key'.format(acct)))
    queries.append(jpq.JPathQuery(
        "region", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].tfstate_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].primary_region'.format(acct)))
    queries.append(jpq.JPathQuery(
        "bucket", '$.accounts[?(workspace=="{0}")].tfstate.network.s3bucket'.format(acct)))
    queries.append(jpq.JPathQuery(
        "dynamodb_table", '$.accounts[?(workspace=="{0}")].tfstate.network.dynanodb_table'.format(acct)))

    return queries

# get the prefix lists defined at account level
def getPrefixListQuery():
    return jpq.JPathQuery("prefix_lists", '$.prefix_lists')

#
def getTFConfig2VarsQueries(acct, vpc):
    var_queries_map = {}

    # prepare for the regions
    var_queries_map["fb_tfstate_region"] = [jpq.JPathQuery(
        "tfstate_region", '$.accounts[?(workspace=="{0}")].tfstate_region'.format(acct))]
    var_queries_map["fb_primary_region"] = [jpq.JPathQuery(
        "primary_region", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].primary_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].primary_region'.format(acct))]
    var_queries_map["fb_dr_region"] = [jpq.JPathQuery(
        "dr_region", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].dr_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].dr_region'.format(acct))]
    var_queries_map["fb_secrets_region"] = [jpq.JPathQuery(
        "secrets_region", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].secrets_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].secrets_region'.format(acct))]

    # prepare for the account terraform workspace
    var_queries_map["account_statefile_s3_bucket"] = [jpq.JPathQuery(
        "tfstate_s3bucket_account", '$.accounts[?(workspace=="{0}")].tfstate.account.s3bucket'.format(acct))]
    var_queries_map["statefile_key"] = [jpq.JPathQuery(
        "statefile_key", '$.accounts[?(workspace=="{0}")].tfstate.statefile_key'.format(acct))]
    var_queries_map["account_workspace"] = [jpq.JPathQuery(
        "workspace", '$.accounts[?(workspace=="{0}")].workspace'.format(acct))]
    
    return var_queries_map
