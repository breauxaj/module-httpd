define httpd::dynamic (
  $priority =       '000',
  $virtualhost =    '*:80',
  $servername =     '',
  $serveralias =    '',
  $serveradmin =    '',
  $setenvs =        '',
  $documentroot =   '',
  $pattern =        '',
  $directoryindex = '',
  $includes =       '',
  $sslcertfile =    '',
  $sslcertkey =     '',
  $sslcertchain =   ''
) {
  include ::httpd

  file { "/etc/httpd/vhost.d/${priority}-${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/dynamic.erb'),
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}
