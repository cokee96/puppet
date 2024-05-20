node puppet-node-2{  
  package { 'nginx':
    ensure => 'installed',
  }

  # Create directory for static content
  file { '/var/www/html/web-example':
    ensure => 'directory',
    mode   => '0755',
  }

  # Create "index.html" file with "hello world" content
  file { '/var/www/html/web-example/index.html':
    ensure  => 'file',
    content => template('example-web/index.html.erb'),
    mode    => '0644',
  }

  # Copy "index.html" to default Nginx location
  file { '/var/www/html/index.html':
    ensure => 'file',
    source => '/var/www/html/web-example/index.html',
    mode   => '0644',
  }

  # Declare correct path for the web
  file_line { 'nginx_web_root':
    path  => '/etc/nginx/nginx.conf',
    line  => '       root         /var/www/html/;',
    match => '^(\s*root\s+/usr/share/nginx/html;)',
  }

  # Restart Nginx
  service { 'nginx':
    ensure => 'running',
    enable => true,
    require => File['/var/www/html/index.html'],
  }
}