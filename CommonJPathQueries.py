import sys
from entities import JPathQuery as jpq


# get Primary region defined at Account level
def getAccountPrimaryRegionQuery(workspace):
    return jpq.JPathQuery("primary_region", '$.accounts[?(workspace=="{0}")].primary_region'.format(workspace))

# get Primary region defined at VPC/Account level
def getVPCPrimaryRegion(acct, vpc):
    return jpq.JPathQuery("primary_region", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].primary_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].primary_region'.format(acct))

# get Account Workspace
def getAccountWorkspaceName(workspace):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].workspace'.format(workspace))

# get VPC workspace
def getVPCWorkspaceName(acct, vpc):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].workspace'.format(acct, vpc))

# get Environment workspace
def getENVWorkspaceName(acct, vpc, env):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].vpcs[?(workspace=="{1}")].environments[?(workspace=="{2}")].workspace'.format(acct, vpc, env))

# get Primary region defined at VPC/Account level
def getintlVPCPrimaryRegion(acct, vpc):
    return jpq.JPathQuery("primary_region", '$.accounts[?(workspace=="{0}")].intl_vpcs[?(workspace=="{1}")].primary_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].primary_region'.format(acct))

# get intl VPC workspace
def getintlVPCWorkspaceName(acct, vpc):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].intl_vpcs[?(workspace=="{1}")].workspace'.format(acct, vpc))

# get intl environment workspace
def getintlENVWorkspaceName(acct, vpc, env):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].intl_vpcs[?(workspace=="{1}")].environments[?(workspace=="{2}")].workspace'.format(acct, vpc, env))

# get Primary region defined at VPC/Account level
def getNFWVPCPrimaryRegion(acct, vpc):
    return jpq.JPathQuery("primary_region", '$.accounts[?(workspace=="{0}")].nfw_vpcs[?(workspace=="{1}")].primary_region'.format(acct, vpc), '$.accounts[?(workspace=="{0}")].primary_region'.format(acct))

# get firewall VPC workspace
def getNFWVPCWorkspaceName(acct, vpc):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].nfw_vpcs[?(workspace=="{1}")].workspace'.format(acct, vpc))

# get firewall environment workspace
def getNFWENVWorkspaceName(acct, vpc, env):
    return jpq.JPathQuery("workspace", '$.accounts[?(workspace=="{0}")].nfw_vpcs[?(workspace=="{1}")].environments[?(workspace=="{2}")].workspace'.format(acct, vpc, env))


