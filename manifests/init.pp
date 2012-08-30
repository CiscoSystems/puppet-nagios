# Class: nagios
# Edgar Magana (eperdomo@cisco.com)
# 
# This class installs nagios
#
# Actions:
#   - Install the nagios package
#
# Sample Usage of this class:
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

  exec { "get-all-available-hosts":
                command => "/usr/bin/python /etc/nagios3/conf.d/nagios_openstack.py",
                refreshonly => true,
                require => File['/etc/nagios3/conf.d/nagios_openstack.py']
        }

  file { "/etc/nagios3/conf.d/nagios_openstack.py":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/nagios_openstack.py",
        require => Package["nagios3"],
    }

 
  file { "/etc/nagios3/conf.d/services_nagios2.cfg":
        notify  => Service["nagios3"],
	ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/services_nagios2.cfg",
	require => Package["nagios3"],
    }
  
  file { "/etc/nagios3/conf.d/localhost_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/localhost_nagios2.cfg",
        require => Package["nagios3"],
    }

file { "/etc/nagios3/conf.d/contacts_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/contacts_nagios2.cfg",
        require => Package["nagios3"],
    }

file { "/etc/nagios3/conf.d/extinfo_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/extinfo_nagios2.cfg",
        require => Package["nagios3"],
    }

file { "/etc/nagios3/conf.d/generic-host_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/generic-host_nagios2.cfg",
        require => Package["nagios3"],
    }

file { "/etc/nagios3/conf.d/generic-service_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/generic-service_nagios2.cfg",
        require => Package["nagios3"],
    }

file { "/etc/nagios3/conf.d/hostgroups_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/hostgroups_nagios2.cfg",
        require => Package["nagios3"],
    } 

file { "/etc/nagios3/conf.d/timeperiods_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/timeperiods_nagios2.cfg",
        require => Package["nagios3"],
    }

}

