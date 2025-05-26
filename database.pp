class database {
  $dbname = 'noeds_email'
  $dbuser = 'coke'
  $upassword = '658078381'

  package { ['mariadb-server', 'MySQL-python']:
    ensure => installed,
  }

  selboolean { 'mysql_connect_any':
    value => 'on',
  }

  service { 'mariadb':
    ensure => running,
    enable => true,
  }

  file { '/var/log/mysqld.log':
    ensure => 'file',
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0775',
  }

  file { '/var/run/mysqld':
    ensure => 'directory',
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0775',
  }

  mysql::db { $dbname:
    user     => $dbuser,
    password => $upassword,
    grant    => ['SELECT', 'UPDATE'],
    host     => 'localhost',
  }

  file { '/tmp/nodes_email.sql':
    ensure  => 'file',
    content => template('deploylamp/nodes_email.sql.erb'),
    mode    => '0644',
  }

  exec { 'restore_database':
    command => "/usr/bin/mysql -h localhost -u '${dbuser}' -p'${upassword}' '${dbname}' < /tmp/nodes_email.sql",
    unless  => "/usr/bin/mysql -h localhost -u '${dbuser}' -p'${upassword}' '${dbname}' -e 'SHOW TABLES' | grep 'ERROR'",
    require => File['/tmp/nodes_email.sql'],
  }
}
