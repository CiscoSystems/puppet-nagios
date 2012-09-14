#! /bin/bash
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


def main():
    node_types = 'compute', 'control', 'swift'
    for node_type in node_types: 
        list_nodes = get_list_nodes(node_type)
        for node in list_nodes:
            host_file_nagios = ("%s_nagios2.cfg" % node)
            os.popen("cp /etc/nagios3/conf.d/%s_template.def /etc/nagios3/conf.d/%s" %(node_type, host_file_nagios))
            os.popen ("perl -p -i -e \"s/localhost/" + node + "/g\" /etc/nagios3/conf.d/%s" %host_file_nagios) 
    sys.exit()

def get_list_nodes(node_type):
    cobbler_file_definition = file('/etc/puppet/manifests/cobbler-node.pp')
    list_nodes = []
    for line in cobbler_file_definition:
        if 'cobbler::node' in line:
            if node_type in line:
                line = line.split('"')[1::2]
                list_nodes = list_nodes + line 
    return list_nodes

if __name__ == '__main__':
    sys.exit(not main())

