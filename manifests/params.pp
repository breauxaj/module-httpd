# Class: httpd::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#   - Does not support other osfamily patterns - redhat only
#
class httpd::params {
  case $::osfamily {
    'redhat': {
      $httpd_root          = '/etc/httpd'

      $httpd_conf          = "${httpd_root}/conf/httpd.conf"

      $httpd_confd         = "${httpd_root}/conf.d"
      $httpd_conf_modulesd = "${httpd_root}/conf.modules.d"
      $httpd_vhostd        = "${httpd_root}/vhost.d"

      $httpd_purge = [
        $httpd_confd,
        $httpd_vhostd
      ]

      $httpd_devel         = 'httpd-devel'
      $httpd_package       = 'httpd'

      $httpd_service       = 'httpd'

      case $::lsbmajdistrelease {
        '7': {
          $httpd_paths = [
            $httpd_root,
            "${httpd_root}/conf",
            $httpd_conf_modulesd,
            '/var/log/httpd'
          ]

        }
        default: {
          $httpd_paths = [
            $httpd_root,
            "${httpd_root}/conf",
            '/var/log/httpd'
          ]

        }
      }
    }
    default: { }
  }

}
