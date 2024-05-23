node puppet-node-2{
  $automation_repository = 'https://github.com/cokee96/automation-web-page.git'
  # Install httpd and php
  package { ['httpd', 'php', 'php-mysql']:
    ensure => 'installed',
  }

  # Install web role specific dependencies
  package { 'git':
    ensure => 'installed',
  }

  # http service state
  service { 'httpd':
    ensure => 'running',
    enable => true,
  }

  # Configure SELinux to allow httpd to connect to remote database
  selboolean { 'httpd_can_network_connect_db':
    value => 'on',
  }

  # Copy the code from repository
  file { '/var/www/html/':
    ensure => 'directory',
  }

  exec { 'clone_repository':
    command => "/usr/bin/git clone ${automation_repository} /var/www/html/",
    creates => '/var/www/html/index.php',
    require => Package['git'],
  }
}


node puppet-node-3{
  $dbname = 'noeds_email'
  $dbuser = 'coke'
  $upassword = '658078381'
  # Install MariaDB package
  package { ['mariadb-server', 'MySQL-python']:
    ensure => 'installed',
  }

  # Configure SELinux to start mysql on any port
  selboolean { 'mysql_connect_any':
    value => 'on',
  }

  # Restart mariadb
  service { 'mariadb':
    ensure => 'running',
    enable => true,
  }

  # Create MariaDB log file
  file { '/var/log/mysqld.log':
    ensure => 'file',
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0775',
  }

  # Create MariaDB PID directory
  file { '/var/run/mysqld':
    ensure => 'directory',
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0775',
  }

  # Start MariaDB Service
  # service { 'mariadb':
  #   ensure => 'running',
  #   enable => true,
  # }

  # Create Application Database
  mysql::db { "${dbname}":
    ensure => 'present',
  }

  # Create Application DB User
  mysql::user { "${dbuser}@%":
    ensure   => 'present',
    password => "${upassword}",
    priv     => '*.*:ALL',
    require  => Mysql::Db["${dbname}"],
  }

  # Copy database dump file
  file { '/tmp/nodes_email.sql.':
    ensure => 'file',
    content => template('/etc/puppetlabs/code/environments/deploy-lamp/modules/sql_database/nodes_email.sql.erb'),
    mode   => '0644',
  }

  # Restore database
  exec { 'restore_database':
    command  => "/usr/bin/mysql -h localhost -u root -p'${root_password}' '${dbname}' < /tmp/nodes_email.sql",
    unless   => "/usr/bin/mysql -h localhost -u root -p'${root_password}' '${dbname}' -e 'SHOW TABLES' | grep 'ERROR'",
    require  => File['/tmp/nodes_email.sql.'],
  }
}
