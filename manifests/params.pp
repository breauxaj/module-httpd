# Class: httpd::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#   - Does not support other osfamily patterns - RedHat 7 only
#
class httpd::params {
  $httpd_package_ensure = 'latest'

  case $::osfamily {
    'RedHat': {
      case $::lsbmajdistrelease {
        '7': {
          $httpd_root          = '/etc/httpd'

          $httpd_conf          = "${httpd_root}/conf/httpd.conf"

          $httpd_confd         = "${httpd_root}/conf.d"
          $httpd_conf_modulesd = "${httpd_root}/conf.modules.d"
          $httpd_vhostd        = "${httpd_root}/vhost.d"

          $httpd_purge = [
            $httpd_confd,
            $httpd_vhostd
          ]

          $httpd_packages      = [
            'httpd',
            'mod_ldap'
          ]

          $httpd_devel         = 'httpd-devel'

          $httpd_service       = 'httpd'

          $httpd_paths = [
            $httpd_root,
            "${httpd_root}/conf",
            $httpd_conf_modulesd,
            '/var/log/httpd'
          ]
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
