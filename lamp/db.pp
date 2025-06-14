class lamp::db {
  $dbname = 'nodes_email'
  $dbuser = 'coke'
  $upassword = '658078381'

  include mysql::server

  selboolean { 'mysql_connect_any':
    value => 'on',
  }

  file_line { 'mariadb_bind_address':
    path   => '/etc/my.cnf.d/mariadb-server.cnf',
    line   => 'bind-address = 0.0.0.0',
    match  => '^bind-address\s*=.*',
    notify => Service['mysqld'],
  }

  mysql::db { $dbname:
    user     => $dbuser,
    password => $upassword,
    host     => 'localhost',
    grant    => ['ALL'],
    require  => Class['mysql::server'],
  }

  file { '/tmp/nodes_email.sql':
    ensure  => file,
    content => template('lamp/nodes_email.sql.erb'), 
    mode    => '0644',
  }

  exec { 'restore_database':
    command => "/usr/bin/mysql -u ${dbuser} -p'${upassword}' ${dbname} < /tmp/nodes_email.sql",
    unless  => "/usr/bin/mysql -u ${dbuser} -p'${upassword}' ${dbname} -e 'SHOW TABLES' | grep 'usuarios'",
    require => [Mysql::Db[$dbname], File['/tmp/nodes_email.sql']],
  }
}
