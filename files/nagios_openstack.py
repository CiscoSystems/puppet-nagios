#!/usr/bin/python
# vim: tabstop=4 shiftwidth=4 softtabstop=4
#
# Copyright 2012 Cisco Systems, Inc.  All rights reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
# @author: Edgar Magana, Cisco Systems Inc.


import os
import sys

DESCRIPTION = """Gets the names of all servers in the OpenStack deployment
from the cobbler system and creates the nagios config files for each one
of them."""


cobbler_file_definition = file('/etc/puppet/manifests/site.pp')
for line in cobbler_file_definition:
	if not line.startswith("#"):
		if 'cobbler_node' in line:
			if 'node_type' in line:
				if not line.startswith("define"):
					host_name, node_type, mac_address, ip_address, power_address = line.split('"')[1::2]
					host_file_nagios = ("%s_nagios2.cfg" % host_name)
					os.popen("cp /etc/nagios3/conf.d/%s_template.def /etc/nagios3/conf.d/%s" %(node_type, host_file_nagios))
					os.popen("perl -p -i -e \"s/localhost/" + host_name + "/g\" /etc/nagios3/conf.d/%s" %host_file_nagios)
