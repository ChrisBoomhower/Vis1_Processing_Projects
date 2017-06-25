#!/usr/bin/env python

from __future__ import print_function

import sys
import threading
import csv
import pandas as pd
import time

from satori.rtm.client import make_client, SubscriptionMode

channel = "USGS-Earthquakes"
endpoint = "wss://open-data.api.satori.com"
appkey = "511caA9dBf4Ddf60aCa5951EFA3DBF4C"


def main():
	with make_client(
			endpoint=endpoint, appkey=appkey) as client:

		print('Connected!')
		
		init = False

		while True:
			mailbox = []
			clean = False
			got_message_event = threading.Event()

			class SubscriptionObserver(object):
				def on_subscription_data(self, data):
					for message in data['messages']:
						mailbox.append(message)
					got_message_event.set()

			
			subscription_observer = SubscriptionObserver()
			client.subscribe(
				channel,
				SubscriptionMode.SIMPLE,
				subscription_observer)


			if not got_message_event.wait(120):
				print("Timeout while waiting for a message")
				sys.exit(1)

			# Iterate through all messages
			for message in mailbox:
				event = []
				
				for k, v in message.items():
					out = False
					
					# Grab message 'properties' data
					if k == 'properties':
						event.append(v)
					
					# Grab message coordinates data
					if k == 'geometry':
						for kk, vv in v.items():
							if kk == 'coordinates':
								event.append({'longitude':vv[0],'latitude':vv[1],'depth':vv[2]})
				
				# Merge properties and coordinates dictionaries together
				z = {**event[0], **event[1]}
				print(z)
				
				# Initialize csv if first pass
				if init == False:
					try:
						with open('earthquake.csv', 'w', newline = '') as csv_file:
							w = csv.DictWriter(csv_file, z.keys())
							w.writeheader()
						init = True
					except PermissionError:
						print('File in use')
				
				# Append new message details to CSV as new row
				while out == False:
					try:
						with open('earthquake.csv', 'a', newline = '') as csv_file:
							w = csv.DictWriter(csv_file, z.keys())
							w.writerow(z)
						out = True
						break
					except PermissionError:
						print('File in use... trying again')
			
			# Cleanup table for import to Processing
			while clean == False:
				try:
					df = pd.read_csv('earthquake.csv')
					df = df.sort_values(by = 'time')
					df = df.drop_duplicates(['time'], keep = 'last')
					df['delta'] = df['time']/1000 - (df['time'].shift(1))/1000
					df['t_lapsed'] = df.delta.cumsum()
					df['dateTime_UTC'] = pd.to_datetime(df['time'], unit = 'ms')
					df = df.fillna(value = 0)
					df.to_csv('earthquakeClean.csv', index = False)
					# with open('earthquake.csv','r') as in_file, open('earthquakeClean.csv','w', newline = '') as out_file:
						# seen = set() # set for fast O(1) amortized lookup
						# for line in in_file:
							# if line in seen: continue # skip duplicate

							# seen.add(line)
							# out_file.write(line)
							
					clean = True
					break
				
				except PermissionError:
					print('earthquakeClean.csv file in use... trying again')

if __name__ == '__main__':
    main()