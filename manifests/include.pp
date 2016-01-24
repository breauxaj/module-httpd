define httpd::include (
  $includes = ''
) {
  file { '/etc/httpd/conf.d/include.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/include.erb'),
  }

}
