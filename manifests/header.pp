define apache::header (
  $headers = '',
  $requestheaders = ''
) {
  file { '/etc/httpd/conf.d/header.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apache/header.erb'),
  }

}