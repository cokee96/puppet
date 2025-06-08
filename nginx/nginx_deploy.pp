class nginx_deploy {

  package { 'nginx':
    ensure => installed,
  }

  file { '/var/www/html':
    ensure => directory,
    mode   => '0755',
  }

  file { '/var/www/html/web-example':
    ensure  => directory,
    mode    => '0755',
    require => File['/var/www/html'],
  }

  file { '/var/www/html/web-example/index.html':
    ensure  => file,
    content => template('example_web/index.html.erb'),
    mode    => '0644',
    require => File['/var/www/html/web-example'],
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    source  => '/var/www/html/web-example/index.html',
    mode    => '0644',
    require => File['/var/www/html/web-example/index.html'],
  }

  file_line { 'nginx_web_root':
    path  => '/etc/nginx/nginx.conf',
    line  => '       root         /var/www/html/;',
    match => '^(\s*root\s+/usr/share/nginx/html;)',
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => File['/var/www/html/index.html'],
  }
}
