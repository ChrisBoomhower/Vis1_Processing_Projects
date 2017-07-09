#!/usr/bin/env python

## Execution Syntax
#### python parseData.py 1 4 NS SA SC SD SH SI SJ
#### python parseData.py startQTR endQTR SEP1 SEP2 SEP3 ...

import os
import glob
import sys
import pandas as pd
import numpy as np

startQTR = int(sys.argv[1])
endQTR = int(sys.argv[2])

SEPList = []

for i in range(3,len(sys.argv)):
    SEPList.append(sys.argv[i])

print(SEPList)


OPMDataFiles = glob.glob(os.path.join("../data", "SampledOPMData*.csv"))

for i in range(0,len(OPMDataFiles)):
    OPMDataFiles[i] = OPMDataFiles[i].replace("\\","/")

print(OPMDataFiles)

SampledOPMDataList = []

for i,j in zip(OPMDataFiles,range(0,len(OPMDataFiles))):
    SampledOPMDataList.append(pd.read_csv(i, dtype = 'str'))

SampledOPMData = pd.concat(SampledOPMDataList).reset_index()


#= pd.read_csv("../data/SampledOPMData.csv", dtype = 'str')

SampledOPMData[['SALARY', 'LOS', 'SEPCount_EFDATE_OCC', 'SEPCount_EFDATE_LOC', 'IndAvgSalary', 'SalaryOverUnderIndAvg',
                'BLS_FEDERAL_OtherSep_Rate', 'BLS_FEDERAL_Quits_Rate', 'BLS_FEDERAL_TotalSep_Level', 'BLS_FEDERAL_JobOpenings_Rate',
                'BLS_FEDERAL_OtherSep_Level', 'BLS_FEDERAL_Quits_Level', 'BLS_FEDERAL_JobOpenings_Level', 'BLS_FEDERAL_Layoffs_Rate',
                'BLS_FEDERAL_Layoffs_Level', 'BLS_FEDERAL_TotalSep_Rate', 'QTR']] \
    = SampledOPMData[['SALARY', 'LOS', 'SEPCount_EFDATE_OCC', 'SEPCount_EFDATE_LOC', 'IndAvgSalary', 'SalaryOverUnderIndAvg',
                'BLS_FEDERAL_OtherSep_Rate', 'BLS_FEDERAL_Quits_Rate', 'BLS_FEDERAL_TotalSep_Level', 'BLS_FEDERAL_JobOpenings_Rate',
                'BLS_FEDERAL_OtherSep_Level', 'BLS_FEDERAL_Quits_Level', 'BLS_FEDERAL_JobOpenings_Level', 'BLS_FEDERAL_Layoffs_Rate',
                'BLS_FEDERAL_Layoffs_Level', 'BLS_FEDERAL_TotalSep_Rate', 'QTR']].apply(pd.to_numeric)


OPMDataFiltered = SampledOPMData[(SampledOPMData["QTR"] >= startQTR) & (SampledOPMData["QTR"] <= endQTR)
                                 & (SampledOPMData["SEP"].isin(SEPList))]

print(len(OPMDataFiltered))

## Average Salary Over Under by Occupation Family

AvgSalOverUnderByOCCFAMT = pd.DataFrame({'CNT' : OPMDataFiltered.groupby(["OCCFAMT"]).size(),
                                         'SUM' : OPMDataFiltered.groupby(["OCCFAMT"])["SalaryOverUnderIndAvg"].sum()}).reset_index()
AvgSalOverUnderByOCCFAMT["AvgSalOverUnder"] = AvgSalOverUnderByOCCFAMT["SUM"]/AvgSalOverUnderByOCCFAMT["CNT"]
AvgSalOverUnderByOCCFAMT["Magnitude"]=np.where(AvgSalOverUnderByOCCFAMT["AvgSalOverUnder"]<0,-AvgSalOverUnderByOCCFAMT["AvgSalOverUnder"],AvgSalOverUnderByOCCFAMT["AvgSalOverUnder"])
AvgSalOverUnderByOCCFAMT = AvgSalOverUnderByOCCFAMT.sort_values("Magnitude", ascending=False).reset_index(drop=True)
del AvgSalOverUnderByOCCFAMT["CNT"], AvgSalOverUnderByOCCFAMT["SUM"], AvgSalOverUnderByOCCFAMT["Magnitude"]

AvgSalOverUnderByOCCFAMT.to_csv('../data/AvgSalOverUnderByOCCFAMT.csv', index = False)


## BLS Data Bubbles

AvgBLS = pd.DataFrame({'CNT' : len(OPMDataFiltered),
                       'SUM' : OPMDataFiltered[['BLS_FEDERAL_TotalSep_Level', 'BLS_FEDERAL_JobOpenings_Level', 'BLS_FEDERAL_Layoffs_Level', 'BLS_FEDERAL_Quits_Level', 'BLS_FEDERAL_OtherSep_Level',
                                                'BLS_FEDERAL_TotalSep_Rate',  'BLS_FEDERAL_JobOpenings_Rate',  'BLS_FEDERAL_Layoffs_Rate',  'BLS_FEDERAL_Quits_Rate',   'BLS_FEDERAL_OtherSep_Rate']].sum()})

AvgBLS["Avg"] = AvgBLS["SUM"]/AvgBLS["CNT"]
del  AvgBLS["SUM"], AvgBLS["CNT"]

AvgBLS = AvgBLS.transpose()
AvgBLS.to_csv('../data/AvgBLS.csv', index = False)


## Guardian Distinct Combinations

DistinctOCCFAMT_AGELVL_LOC_SALLVL = pd.DataFrame({'CNT' : OPMDataFiltered.groupby(["OCCFAMT", "AGELVLT", "LOCT", "SALLVLT"]).size()}).reset_index()
DistinctOCCFAMT_AGELVL_LOC_SALLVL = DistinctOCCFAMT_AGELVL_LOC_SALLVL.sort_values("CNT", ascending=False).reset_index(drop=True)
DistinctOCCFAMT_AGELVL_LOC_SALLVL.to_csv('../data/DistinctOCCFAMT_AGELVL_LOC_SALLVL.csv', index = False)





