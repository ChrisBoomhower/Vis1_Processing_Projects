#!/usr/bin/env python

## Execution Syntax
#### python parseKeyAttributeRelationships.py 1 WORKSCHT "Full-time Nonseasonal"
#### python parseKeyAttributeRelationships.py Add_Remove catType catValue

import os
import glob
import sys
import pandas as pd
import numpy as np

# 0 = Remove a category
# 1 = Add a category
Add_Remove = int(sys.argv[1])

# PATCO
# AGELVLT
# WORKSCHT
# SALLVLT
catType = sys.argv[2]

# Value Selected in Quotes "xx yyy zzzz"
catValue = sys.argv[3]

path = os.path.join("../data", "DistinctPATCO_AGELVL_WORKSCH_SALLVL_FINAL.csv")
print(path)
CurrentDF = pd.read_csv(path, dtype='str')

if(Add_Remove == 0):
    print(len(CurrentDF))
    CurrentDF = CurrentDF[CurrentDF[catType] != catValue].drop_duplicates()
    print(len(CurrentDF))
else:
    path = os.path.join("../data", "DistinctPATCO_AGELVL_WORKSCH_SALLVL.csv")
    print(path)
    OriginalDF = pd.read_csv(path, dtype='str')

    print(len(CurrentDF))
    CurrentDF = pd.concat([CurrentDF, OriginalDF[OriginalDF[catType] == catValue]]).drop_duplicates()
    print(len(CurrentDF))


CurrentDF.to_csv('../data/DistinctPATCO_AGELVL_WORKSCH_SALLVL_FINAL.csv', index = False)