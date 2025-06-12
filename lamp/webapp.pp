class lamp::webserver {
  $automation_repository = 'https://github.com/cokee96/automation-web-page.git'

  package { ['httpd', 'php', 'php-mysql', 'git']:
    ensure => installed,
  }

  service { 'httpd':
    ensure => running,
    enable => true,
  }

  selboolean { 'httpd_can_network_connect_db':
    value => 'on',
  }

  file { '/var/www/html/':
    ensure => directory,
  }

  exec { 'clone_repository':
    command => "/usr/bin/git clone ${automation_repository} /var/www/html/",
    creates => '/var/www/html/index.php',
    require => Package['git'],
  }
}
