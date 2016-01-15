# Class: httpd::devel
#
# This class installs Apache httpd devel package
#
# Parameters:
#
#  ensure: (default latest)
#    Determine which version to download
#
# Actions:
#   - Install Apache httpd devel package
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'httpd::devel': }
#
class httpd::devel (
  $ensure = 'latest'
) inherits ::httpd::params {
  package { $::httpd::params::httpd_devel:
    ensure  => $ensure,
    require => Package[$::httpd::params::httpd_package],
  }

}
