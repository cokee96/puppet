# Define the packages to install
$packages = ['httpd', 'git', 'python3', 'python3-pip', 'nodejs', 'npm', 'mysql-server']

# Install the packages
package { $packages:
  ensure => 'installed',
}

# Start and enable services
service { ['httpd', 'nodejs', 'npm', 'mysql-server']:
  ensure => 'running',
  enable => true,
}