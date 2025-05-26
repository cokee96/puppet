node puppet-node-2{
  # Define the packages to install
  $packages = ['httpd', 'git', 'python3', 'python3-pip', 'nodejs', 'npm']

  # Install the packages
  package { $packages:
    ensure => 'installed',
  }

  # Start and enable services
  service { ['httpd']:
    ensure => 'running',
    enable => true,
  }
}
