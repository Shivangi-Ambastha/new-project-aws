import boto3
import TFFileHelper as tffile
import TFJsonHelper as tfjson
import CommonJPathQueries as cjpq
from entities import JPathQuery as jpq


#
def getAccountPrimaryRegionQuery(fb_terraform_config, workspace):
    pr_query = cjpq.getAccountPrimaryRegionQuery(workspace)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getVPCPrimaryRegion(fb_terraform_config, acct, vpc):
    pr_query = cjpq.getVPCPrimaryRegion(acct, vpc)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getAccountWorkspaceName(fb_terraform_config, workspace):
    pr_query = cjpq.getAccountWorkspaceName(workspace)
    return tfjson.getValue(fb_terraform_config, pr_query).value


#
def getVPCWorkspaceName(fb_terraform_config, acct, vpc):
    pr_query = cjpq.getVPCWorkspaceName(acct, vpc)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getENVWorkspaceName(fb_terraform_config, acct, vpc, env):
    pr_query = cjpq.getENVWorkspaceName(acct, vpc, env)
    return tfjson.getValue(fb_terraform_config, pr_query).value

def getintlVPCPrimaryRegion(fb_terraform_config, acct, vpc):
    pr_query = cjpq.getintlVPCPrimaryRegion(acct, vpc)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getintlVPCWorkspaceName(fb_terraform_config, acct, vpc):
    pr_query = cjpq.getintlVPCWorkspaceName(acct, vpc)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getintlENVWorkspaceName(fb_terraform_config, acct, vpc, env):
    pr_query = cjpq.getintlENVWorkspaceName(acct, vpc, env)
    return tfjson.getValue(fb_terraform_config, pr_query).value

def getNFWVPCPrimaryRegion(fb_terraform_config, acct, vpc):
    pr_query = cjpq.getNFWVPCPrimaryRegion(acct, vpc)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getNFWVPCWorkspaceName(fb_terraform_config, acct, vpc):
    pr_query = cjpq.getNFWVPCWorkspaceName(acct, vpc)
    return tfjson.getValue(fb_terraform_config, pr_query).value

#
def getNFWENVWorkspaceName(fb_terraform_config, acct, vpc, env):
    pr_query = cjpq.getNFWENVWorkspaceName(acct, vpc, env)
    return tfjson.getValue(fb_terraform_config, pr_query).value



