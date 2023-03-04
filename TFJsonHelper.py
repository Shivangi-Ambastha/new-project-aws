import json
from jsonpath_ng.ext import parse
from jsonpath_ng import jsonpath
import TFFileHelper as tffile
from entities import JPathQuery

#
def evalExpression(json_data, query: JPathQuery):
    
    #find matches for the primary expression
    expression  = parse(query.expression)
    matches    = expression.find(json_data)

    # if no matches, try to find matches for alt_expression
    if len(matches) == 0 and (not query.alt_expression is None):
        expression  = parse(query.alt_expression)
        matches    = expression.find(json_data)

    if len(matches) > 0:
        if query.considerAllMatches:
            query.value =  [match.value for match in matches]
        else:
            query.value =  matches[0].value
    else:
        query.value =  None
    
    return query


#
def getValue(file_path: str, query: JPathQuery):
    #load the json data
    json_data = tffile.getJsonData(file_path)
    #if json data is empty, return
    if json_data is None:
        return query
        
    return evalExpression(json_data, query)    


# 
def getValues(file_path: str, queries: []):
    
    #load the json data
    json_data = tffile.getJsonData(file_path)
    #if json data is empty, return
    if json_data is None:
        return queries

    # read key and jpath query
    for query in queries:
        query = evalExpression(json_data, query)

    return queries

    
