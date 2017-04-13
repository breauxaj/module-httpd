define httpd::alias (
  $aliases = '',
  $aliasmatches = '',
) {
  include ::httpd

  file { $::httpd::params::httpd_alias:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/alias.erb'),
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}