#!/bin/env python
# Python script to check all states in an output JSON and raise an alert if any states did not pass (result = true).
# Jesse Rhoads <jesserhoads@gmail.com>
import json
import argparse
version_string = 'check_result 0.1'

def alert_the_media(state):
    # To-Do: Put code in here to trigger something, like a zabbix or slack alert.
    msg = "State {} failed to return true!".format(state)
    raise Exception(msg)

def getargs():
    parser = argparse.ArgumentParser(description=version_string)
    parser.add_argument('file', help='File that contains JSON output from Salt')
    return parser.parse_args()

def main(args):
    with open(args.file) as data_file:
        data = json.load(data_file)

    for host in data:
      for state in data[host]:
        if data[host][state]["result"] is not True:
          alert_the_media(state)
        else:
          print "Host {} State {} completed OK.".format(host,state)

if __name__ == '__main__':
    args = getargs()
    main(args)

