define apache::raw (
  $content = '',
) {
  file { "/etc/httpd/conf.d/${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apache/raw.erb'),
  }

}