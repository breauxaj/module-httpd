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
  $proxies = '',
  $includes = '',
  $rewrites = '',
  $tohttps = '',
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
    content => template('httpd/virtual.erb'),
    notify  => Service[$service],
  }

}
