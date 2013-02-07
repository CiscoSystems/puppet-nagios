#!/usr/bin/env python
# -*- encoding: utf-8 -*-
#
# Keystone monitoring script for Nagios
#
# Copyright © 2012 eNovance <licensing@enovance.com>
#
# Author: Florian Lambert <florian.lambert@enovance.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


#needed python-novaclient
#https://github.com/openstack/python-novaclient

import sys
import argparse

from novaclient.v1_1 import client


STATE_OK = 0
STATE_WARNING = 1
STATE_CRITICAL = 2
STATE_UNKNOWN = 3


#2 Warn = 1 Critical
def return_state(state):
  global RETURN_STATE
  global STATE_MESSAGE
  RETURN_STATE += state
  if RETURN_STATE > 1:
    STATE_MESSAGE +=" does not work"
    print STATE_MESSAGE
    sys.exit(STATE_CRITICAL)

def collect_args():
  parser = argparse.ArgumentParser(description='Check an OpenStack glance server.')
  parser.add_argument('--auth_url', metavar='URL', type=str,
        required=True,
        help='Keystone URL')
  parser.add_argument('--username', metavar='username', type=str,
        required=True,
        help='username to use for authentication')
  parser.add_argument('--password', metavar='password', type=str,
        required=True,
        help='password to use for authentication')
  parser.add_argument('--tenant', metavar='tenant', type=str,
        required=True,
        help='tenant name to use for authentication')
  return parser

def check_novaapi(nt):

  global RETURN_STATE
  global STATE_MESSAGE
  RETURN_STATE = STATE_OK
  STATE_MESSAGE = "Failed -"

  #flavors
  if not len(nt.flavors.list(detailed=False)) >= 1:
    STATE_MESSAGE +=" flavors.list >=1"
    return_state(STATE_WARNING)

  #servers
  if not nt.servers.list():
    STATE_MESSAGE +=" servers.list==false"
    return_state(STATE_WARNING)

  #images
  if not len(nt.images.list(detailed=False)) >= 1:
    STATE_MESSAGE +=" images.list >=1"
    return_state(STATE_WARNING)

  #security_groups
  if not len(nt.security_groups.list()) >= 1:
    STATE_MESSAGE +=" security_groups >=1"
    return_state(STATE_WARNING)



  if RETURN_STATE == STATE_WARNING:
    STATE_MESSAGE +=" does not work"
    print STATE_MESSAGE
  else:
    print "OK - Nova-api Connection established"

  return RETURN_STATE

if __name__ == '__main__':
  args = collect_args().parse_args()
  try:
    nt = client.Client(args.username,
         args.password,
         args.tenant,
         args.auth_url,
         service_type="compute")
    sys.exit(check_novaapi(nt))
  except Exception as e:
  	print str(e)
  	sys.exit(STATE_CRITICAL)
