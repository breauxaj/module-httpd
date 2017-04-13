define httpd::include (
  $includes = ''
) {
  include ::httpd

  file { $::httpd::params::httpd_include:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/include.erb'),
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}
