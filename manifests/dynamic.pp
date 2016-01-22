define httpd::dynamic (
  $priority = '000',
  $virtualhost = '*:80',
  $servername = '',
  $serveralias = '',
  $serveradmin = '',
  $documentroot = '',
  $pattern = '',
  $directoryindex = '',
  $includes = ''
) {
  include ::httpd

  $httpd_version = $::httpd_version

  file { "/etc/httpd/vhost.d/${priority}-${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apache/dynamic.erb'),
    notify  => Service[$::httpd::params::httpd_service],
  }

}
