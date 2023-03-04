import json

def getResponseCode(response: dict):
    return response['ResponseMetadata']['HTTPStatusCode']
