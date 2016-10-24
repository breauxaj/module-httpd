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
  $ensure = $::httpd::params::httpd_package_ensure
) inherits ::httpd::params {
  case $::osfamily {
    'RedHat': {
      case $::lsbmajdistrelease {
        '7': {
          package { $::httpd::params::httpd_devel:
            ensure  => $ensure,
            require => Package[$::httpd::params::httpd_package],
          }
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::osfamily} ${::operatingsystemmajrelease} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
