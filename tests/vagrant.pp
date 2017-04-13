node default {
  include ::httpd
  include ::httpd::devel

  case $::operatingsystem {
    'Amazon': {
        Package { allow_virtual => false }
    }
    default: {}
  }

  file { '/etc/httpd/vhost.d/testfile.inc':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => '# placeholder',
    require => Package[$::httpd::params::httpd_packages]
  }

  file { '/var/www/html/index.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => '<h1>vagrant</h1>',
    require => Package[$::httpd::params::httpd_packages]
  }

  httpd::alias { 'vagrant':
    aliases => [ '/test /var/www/html' ],
  }
  
  httpd::dav { 'vagrant': }

  httpd::dynamic { 'vagrant':
    servername   => 'domain.com',
    serveralias  => '*.domain.com',
    documentroot => '/var/www/dynamic',
    pattern      => '%1/web',
  }

  httpd::header { 'vagrant':
    headers => [ "set X-Backend ${::hostname}" ],
  }

  httpd::include { 'vagrant':
    includes => [ '/etc/httpd/vhost.d/testfile.inc' ],
  }

  httpd::raw { 'vagrant':
    content => '# another placeholder',
  }

  httpd::sysconfig { 'vagrant':
    options => [ 'PRODUCTION'],
  }

  httpd::virtual { 'default':
    priority     => '000',
    virtualhost  => '_default_:80',
    servername   => "${::hostname}.domain2.com",
    documentroot => '/var/www/html',
  }

}
