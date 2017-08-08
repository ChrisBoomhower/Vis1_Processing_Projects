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

for i in OPMDataFiles:
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

# Fix differences in spaces on WORKSCHT Column
OPMDataFiltered["WORKSCHT"] = np.where(OPMDataFiltered["WORKSCHT"].str[0]=="F", 'Full-time Nonseasonal',
                                np.where(OPMDataFiltered["WORKSCHT"].str[0]=="I", 'Intermittent Nonseasonal',
                                         np.where(OPMDataFiltered["WORKSCHT"].str[0]=="P", 'Part-time Nonseasonal',
                                                  np.where(OPMDataFiltered["WORKSCHT"].str[0]=="G", 'Full-time Seasonal',
                                                        np.where(OPMDataFiltered["WORKSCHT"].str[0]=="J", 'Intermittent Seasonal',
                                                                np.where(OPMDataFiltered["WORKSCHT"].str[0]=="Q", 'Part-time Seasonal',
                                                                        np.where(OPMDataFiltered["WORKSCHT"].str[0]=="T", 'Part-time Job Sharer Seasonal',
                                                                                np.where(OPMDataFiltered["WORKSCHT"].str[0]=="S", 'Part-time Job Sharer Nonseasonal',
                                                                                        np.where(OPMDataFiltered["WORKSCHT"].str[0]=="B", 'Full-time Nonseasonal Baylor Plan',
                                                                                                'NO WORK SCHEDULE REPORTED' ### ELSE case represents Night
                                                                                                 )
                                                                                         )
                                                                                 )
                                                                         )
                                                                 )
                                                          )
                                                 )
                                        )
                               )

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

AGELVLTMagnitude = pd.DataFrame({'AGELVLTMagnitude' : OPMDataFiltered.groupby(["AGELVLT"]).size()}).sort_values("AGELVLTMagnitude", ascending = False).reset_index()
WORKSCHTMagnitude = pd.DataFrame({'WORKSCHTMagnitude' : OPMDataFiltered.groupby(["WORKSCHT"]).size()}).sort_values("WORKSCHTMagnitude", ascending = False).reset_index()
SALLVLTMagnitude = pd.DataFrame({'SALLVLTMagnitude' : OPMDataFiltered.groupby(["SALLVLT"]).size()}).sort_values("SALLVLTMagnitude", ascending = False).reset_index()

DistinctPATCO_AGELVL_WORKSCH_SALLVL = pd.DataFrame({'CNT' : OPMDataFiltered.groupby(["PATCO", "AGELVLT", "WORKSCHT", "SALLVLT"]).size()}).reset_index()
DistinctPATCO_AGELVL_WORKSCH_SALLVL = DistinctPATCO_AGELVL_WORKSCH_SALLVL.merge(AGELVLTMagnitude, on = "AGELVLT", how = 'left')
DistinctPATCO_AGELVL_WORKSCH_SALLVL = DistinctPATCO_AGELVL_WORKSCH_SALLVL.merge(WORKSCHTMagnitude, on = "WORKSCHT", how = 'left')
DistinctPATCO_AGELVL_WORKSCH_SALLVL = DistinctPATCO_AGELVL_WORKSCH_SALLVL.merge(SALLVLTMagnitude, on = "SALLVLT", how = 'left')

DistinctOCCFAMT_AGELVL_WORKSCHWORKSCH_SALLVL = DistinctPATCO_AGELVL_WORKSCH_SALLVL.sort_values("CNT", ascending=False).reset_index(drop=True)
DistinctOCCFAMT_AGELVL_WORKSCHWORKSCH_SALLVL.to_csv('../data/DistinctPATCO_AGELVL_WORKSCH_SALLVL.csv', index = False)
DistinctOCCFAMT_AGELVL_WORKSCHWORKSCH_SALLVL.to_csv('../data/DistinctPATCO_AGELVL_WORKSCH_SALLVL_FINAL.csv', index = False)

AGELVLTMagnitude.to_csv('../data/AGELVLTMagnitude.csv', index = False)
WORKSCHTMagnitude.to_csv('../data/WORKSCHTMagnitude.csv', index = False)
SALLVLTMagnitude.to_csv('../data/SALLVLTMagnitude.csv', index = False)

