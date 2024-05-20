# Instalar el paquete nginx
package { 'nginx':
  ensure => 'installed',
}

# Crear directorio para el contenido estático
file { '/var/www/html/web-example':
  ensure => 'directory',
  mode   => '0755',
}

# Plantilla para el archivo "index.html" con el contenido dinámico
file { '/var/www/html/hello-world/index.html':
  ensure  => 'file',
  content => template('module_name/index.html.erb'),
  mode    => '0644',
}

# Copiar "index.html" a la ubicación predeterminada de Nginx
file { '/var/www/html/index.html':
  ensure => 'file',
  source => '/var/www/html/hello-world/index.html',
  mode   => '0644',
}

# Habilitar el sitio web predeterminado de Nginx
file { '/etc/nginx/sites-enabled/default':
  ensure => 'link',
  target => '/etc/nginx/sites-available/default',
}

# Reiniciar Nginx
service { 'nginx':
  ensure => 'running',
  enable => true,
  require => File['/etc/nginx/sites-enabled/default'],
}