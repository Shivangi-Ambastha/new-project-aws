import os
import json

single_quote_content_format = '{0} ={1} \n'

# validate if file exists
def isFileExists(file_path: str):
  #delete the auto-generated file
  if os.path.exists(file_path):
    return True
  
  return False


#get the JSON data from file
def getJsonData(file_path): 
  json_data = None
  #load the configuration json file
  if isFileExists(file_path):
    with open(file_path, 'r') as f:
        json_data = json.load(f)

  return json_data


def deleteIfExists(file_path: str):
  #delete the auto-generated file
  if isFileExists(file_path):
    os.remove(file_path)

# delete and create the existing file
def deleteAndCreateEmpty(file_path: str):
  #delete the auto-generated file
  if isFileExists(file_path):
    os.remove(file_path)

  with open(file_path, 'a') as file1: 
      file1.write("#this is auto generate file \n")
      file1.write("#do not check-in to source repo \n\n")

# append the content to file
def writeJson(file_path: str, json_content):

    with open(file_path, 'w') as file1: 
        json.dump(json_content, file1, indent=4)

# append the array to file
def appendArray(file_path: str, key: str, arr: []):

    with open(file_path, 'a') as file1: 
        file1.write("\n")
        file1.write(single_quote_content_format.format(key, json.dumps(arr)))


# append all items in dictionary,  to file
def appendDictionary(file_path: str, values: dict):
    
    with open(file_path, 'a') as file1:         
        file1.write("\n")
        for key in values:
          if not values[key] is None:
            file1.write(single_quote_content_format.format(key, json.dumps(values[key])))
          else:
            print("{0}  value is None".format(key))    


# append all items in dictionary,  to file
def appendJPathValues(file_path: str, values: []):
    
    with open(file_path, 'a') as file1:         
        file1.write("\n")
        for obj in values:
          if not obj.value is None:
            obj_val = json.dumps(obj.value) if obj.jsonDumpRequired else obj.value
            file1.write(single_quote_content_format.format(obj.key, obj_val))
          else:
            print("{0}  value is None".format(obj.key))   