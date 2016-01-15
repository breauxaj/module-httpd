define apache::dynamic (
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
  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'httpd',
  }

  file { "/etc/httpd/vhost.d/${priority}-${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apache/dynamic.erb'),
    notify  => Service[$service],
  }

}
