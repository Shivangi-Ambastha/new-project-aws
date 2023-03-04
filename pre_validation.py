#validate python version installed

import sys

minimum_major_version = 3
minimum_minor_version = 9
isValid_version = False

#get the current python version 
pyinfo = sys.version_info
print("Current python version {0}.{1} ".format(pyinfo.major, pyinfo.minor))

if pyinfo.major >= minimum_major_version and pyinfo.minor >=minimum_minor_version:
    isValid_version = True

if not isValid_version: 
    print("Require python version >= {0}.{1} \n".format(minimum_major_version, minimum_minor_version))
    exit(1)