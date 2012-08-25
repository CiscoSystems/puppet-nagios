# Class: nagios
# Edgar Magana (eperdomo@cisco.com)
# 
# This class installs nagios
#
# Actions:
#   - Install the nagios package
#
# Sample Usage:
#  class { 'nagios': }
#
class nagios {

  service { "nagios3":
	ensure  => "running",
	enable  => "true",
	require => Package["nagios3"],
}

  package { 'nagios3':
        ensure => installed,
  }
 
  file { "/etc/nagios3/conf.d/services_nagios2.cfg":
        notify  => Service["nagios3"],
	ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0600,
        source  => "puppet:///modules/nagios/services_nagios2.cfg",
	require => Package["nagios3"],
    }
}

