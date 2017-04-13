define httpd::virtual (
  $priority = '000',
  $virtualhost = '*:80',
  $servername = '',
  $serveralias = '',
  $serveradmin = '',
  $setenvs = '',
  $documentroot = '',
  $directoryindex = '',
  $directories = '',
  $aliases = '',
  $aliasmatches = '',
  $headers = '',
  $requestheaders = '',
  $phpflags = '',
  $phpvalues = '',
  $proxies = '',
  $includes = '',
  $rewrites = '',
  $tohttps = '',
  $sslcertfile = '',
  $sslcertkey = '',
  $sslcertchain = ''
) {
  include ::httpd

  file { "${::httpd::params::httpd_vhostd}/${priority}-${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/virtual.erb'),
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}
