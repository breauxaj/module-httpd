# Class: httpd::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#   - Does not support other osfamily patterns - RedHat family
#
class httpd::params {
  $httpd_package_ensure = 'latest'

  case $::osfamily {
    'RedHat': {
      $httpd_root          = '/etc/httpd'
      $httpd_confd         = "${httpd_root}/conf.d"

      $httpd_alias         = "${httpd_confd}/alias.conf"
      $httpd_dav           = "${httpd_confd}/dav.conf"
      $httpd_header        = "${httpd_confd}/header.conf"
      $httpd_include       = "${httpd_confd}/include.conf"      
      $httpd_conf          = "${httpd_root}/conf/httpd.conf"
      $httpd_conf_modulesd = "${httpd_root}/conf.modules.d"
      $httpd_vhostd        = "${httpd_root}/vhost.d"

      $httpd_paths = [
        $httpd_root,
        "${httpd_root}/conf",
        $httpd_conf_modulesd,
        '/var/log/httpd'
      ]

      $httpd_purge = [
        $httpd_confd,
        $httpd_vhostd
      ]

      $httpd_service       = 'httpd'
      $httpd_sysconfig     = '/etc/sysconfig/httpd'

      case $::operatingsystem {
        'Amazon': {
          case $::operatingsystemmajrelease {
            default: {
              $httpd_devel         = 'httpd24-devel'

              $httpd_packages      = [
                'httpd24',
                'mod24_ldap'
              ]
            }
          }
        }
        default: {
          case $::operatingsystemmajrelease {
            '7': {
              $httpd_devel         = 'httpd-devel'

              $httpd_packages      = [
                'httpd',
                'mod_ldap'
              ]
            }
            default: {
              fail("The ${module_name} module is not supported on an ${::osfamily} ${::operatingsystemmajrelease} distribution.")
            }
          }
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
