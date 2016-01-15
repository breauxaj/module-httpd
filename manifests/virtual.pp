define apache::virtual (
  $priority = '000',
  $virtualhost = '*:80',
  $servername = '',
  $serveralias = '',
  $serveradmin = '',
  $documentroot = '',
  $directoryindex = '',
  $aliases = '',
  $aliasmatches = '',
  $headers = '',
  $requestheaders = '',
  $jkmountfile = '',
  $wsgidaemonprocess = '',
  $wsgiprocessgroup = '',
  $wsgiscriptalias = '',
  $proxy_pass = '',
  $includes = '',
  $rewrites = '',
  $sslcertfile = '',
  $sslcertkey = '',
  $sslcertchain = ''
) {
  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'httpd',
  }

  file { "/etc/httpd/vhost.d/${priority}-${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apache/virtual.erb'),
    notify  => Service[$service],
  }

}
