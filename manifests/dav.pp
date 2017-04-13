define httpd::dav {
  include ::httpd

  file { $::httpd::params::httpd_dav:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/dav.erb'),
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}
