define httpd::header (
  $headers = '',
  $requestheaders = ''
) {
  include ::httpd

  file { '/etc/httpd/conf.d/header.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/header.erb'),
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}