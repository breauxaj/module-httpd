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
  $ensure = $::httpd::params::httpd_package_ensure
) inherits ::httpd::params {
  case $::osfamily {
    'RedHat': {
      package { $::httpd::params::httpd_packages:
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
        notify  => Service[$::httpd::params::httpd_service],
        require => Package[$::httpd::params::httpd_packages],
      }

      file { $::httpd::params::httpd_paths:
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => Package[$::httpd::params::httpd_packages],
      }

      file { '/etc/httpd/conf.d/status.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('httpd/status.erb'),
        notify  => Service[$::httpd::params::httpd_service],
        require => Package[$::httpd::params::httpd_packages],
      }

      $alias = hiera_hash('httpd::aliases',{})
      create_resources('httpd::alias',$alias)

      $config = hiera_hash('httpd',{})
      create_resources('httpd::config',$config)

      $dynamic = hiera_hash('httpd::dynamic',{})
      create_resources('httpd::dynamic',$dynamic)

      $header = hiera_hash('httpd::headers',{})
      create_resources('httpd::header',$header)

      $include = hiera_hash('httpd::includes',{})
      create_resources('httpd::include',$include)

      $raw = hiera_hash('httpd::raw',{})
      create_resources('httpd::raw',$raw)

      $sysconfig = hiera_hash('httpd::sysconfig',{})
      create_resources('httpd::sysconfig',$sysconfig)

      $virtual = hiera_hash('httpd::virtuals',{})
      create_resources('httpd::virtual',$virtual)

      service { $::httpd::params::httpd_service:
        ensure  => running,
        enable  => true,
        require => Package[$::httpd::params::httpd_packages],
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
