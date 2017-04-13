define httpd::raw (
  $content
) {
  include ::httpd

  file { "${::httpd::params::httpd_confd}/${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $content,
    notify  => Service[$::httpd::params::httpd_service],
    require => Package[$::httpd::params::httpd_packages],
  }

}
