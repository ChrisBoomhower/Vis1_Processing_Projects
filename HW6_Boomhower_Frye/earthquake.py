#!/usr/bin/env python

from __future__ import print_function

import sys
import threading
import csv

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


			if not got_message_event.wait(30):
				print("Timeout while waiting for a message")
				sys.exit(1)

			for message in mailbox:
				#print('Got message "{0}"'.format(message))
				#for key, value in message.items():
				#	print([key, value])
				for k, v in message.items():
					#print([k,v])
					if k == 'properties':
						for kk, vv in v.items():
							print([kk,vv])
						if init == False:
							with open('earthquake.csv', 'w', newline = '') as csv_file:
								w = csv.DictWriter(csv_file, v.keys())
								w.writeheader()
							init = True
						
						with open('earthquake.csv', 'a', newline = '') as csv_file:
							w = csv.DictWriter(csv_file, v.keys())
							w.writerow(v)
							
				# if init == False:
					# with open('earthquake.csv', 'w') as csv_file:
						# w = csv.DictWriter(csv_file, message.keys())
						# w.writeheader()
					# init = True
				
				# with open('earthquake.csv', 'a') as csv_file:
					# w = csv.DictWriter(csv_file, message.keys())
					# w.writerow(message)
					#for key, value in message.items():
					#	writer.writerow([key, value])


if __name__ == '__main__':
    main()