define httpd::dav (
  $davlockdb = '/var/lib/dav/lockdb'
) {
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
