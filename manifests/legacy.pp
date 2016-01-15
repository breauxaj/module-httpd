define apache::legacy (
  $includes = ''
) {
  file { '/etc/httpd/conf.d/legacy.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apache/legacy.erb'),
  }

}