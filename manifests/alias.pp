define httpd::alias (
  $aliases = '',
  $aliasmatches = '',
) {
  include ::httpd

  file { '/etc/httpd/conf.d/alias.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/alias.erb'),
    notify  => Service[$::httpd::params::httpd_service],
  }

}
