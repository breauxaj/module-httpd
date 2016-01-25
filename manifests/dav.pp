define httpd::dav {
  include ::httpd

  file { '/etc/httpd/conf.d/dav.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/dav.erb'),
    notify  => Service[$::httpd::params::httpd_service],
  }

}
