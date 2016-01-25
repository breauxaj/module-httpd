# Class: httpd
#
# This class installs Apache httpd
#
# Parameters:
#
#  ensure: (default latest)
#    Determine which version to download
#
# Actions:
#   - Install Apache httpd
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'httpd': }
#
class httpd (
  $ensure = 'latest'
) inherits ::httpd::params {
  package { $::httpd::params::httpd_package:
    ensure  => $ensure,
  }

  file { $::httpd::params::httpd_purge:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
    require => Package[$::httpd::params::httpd_package],
  }

  file { $::httpd::params::httpd_paths:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package[$::httpd::params::httpd_package],
  }

  service { $::httpd::params::httpd_service:
    ensure  => running,
    enable  => true,
    require => Package[$::httpd::params::httpd_package],
  }

  notify { 'httpd_version':
    message => ">>> httpd_version is '${::httpd_version}'"
  }

}
