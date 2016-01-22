define httpd::dynamic (
  $priority = '000',
  $virtualhost = '*:80',
  $servername = '',
  $serveralias = '',
  $serveradmin = '',
  $documentroot = '',
  $pattern = '',
  $directoryindex = '',
  $includes = ''
) {
  include ::httpd

  file { "/etc/httpd/vhost.d/${priority}-${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('httpd/dynamic.erb'),
    notify  => Service[$::httpd::params::httpd_service],
  }

  notify { 'httpd_version_in_dynamic':
    message => ">>> httpd_version is '${::httpd_version}'"
  }

}
