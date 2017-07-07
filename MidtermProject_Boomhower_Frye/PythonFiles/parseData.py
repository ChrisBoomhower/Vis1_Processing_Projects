#!/usr/bin/env python

import sys
import pandas as pd

print(sys.argv[1], sys.argv[2])

df = pd.DataFrame([sys.argv[1], sys.argv[2]])

print(df)

df.to_csv('test.csv', index = False)