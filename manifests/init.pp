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
        #require => Exec["get-all-available-hosts"]
  }

  exec { "get-all-available-hosts":
                command => "python /etc/nagios3/conf.d/nagios_openstack.py",
                path => "/bin:/usr/bin:/sbin:/usr/sbin",
		logoutput => true,
                notify  => Service["nagios3"],
                require => File['/etc/nagios3/conf.d/nagios_openstack.py']
        }
  
  file { "/etc/nagios3/conf.d/localhost_nagios2.cfg":
        notify  => Service["nagios3"],
        ensure => absent,
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


   file { "/etc/nagios3/htpasswd.users":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/htpasswd.users",
        require => Package["nagios3"],
    }


    file { "/etc/nagios3/cgi.cfg":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/cgi.cfg",
        require => Package["nagios3"],
    }

    
     file { "/etc/nagios3/apache2.conf":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/apache2.conf",
        require => Package["nagios3"],
    }


file { "/etc/nagios3/conf.d/control_template.def":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/control_template.def",
        require => Package["nagios3"],
    }
 

file { "/etc/nagios3/conf.d/compute_template.def":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/compute_template.def",
        require => Package["nagios3"],
    }

file { "/etc/nagios3/conf.d/swift_template.def":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/nagios/swift_template.def",
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


file { "/usr/lib/nagios/plugins/check_glance1":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_glance1",
        require => Package["nagios3"],
    }


file { "/usr/lib/nagios/plugins/check_keystone":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_keystone",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_novaapi":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_novaapi",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_rabbitmq_aliveness":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_rabbitmq_aliveness",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_rabbitmq_objects":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_rabbitmq_objects",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_rabbitmq_overview":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_rabbitmq_overview",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_rabbitmq_server":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_rabbitmq_server",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_rabbitmq_queue":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_rabbitmq_queue",
        require => Package["nagios3"],
    }

file { "/usr/lib/nagios/plugins/check_vm":
        notify  => Service["nagios3"],
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/nagios/check_vm",
        require => Package["nagios3"],
    }

}

