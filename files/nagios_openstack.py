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
    f=os.popen("cobbler system list")
    for i in f:
        j = i[:-1]
        host_file_nagios = ("%s_nagios2.cfg" % j).strip()
        host_nagios = j.strip()
        os.popen("cp localhost_nagios2.cfg %s" %host_file_nagios)
        os.popen ("perl -p -i -e \"s/localhost/" + host_nagios + "/g\" %s" %host_file_nagios) 

if __name__ == '__main__':
    sys.exit(not main())

