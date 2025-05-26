import 'nginx_deploy.pp'

node 'puppet-node-2' {
  include nginx_deploy
}

node default {
  notify { 'Default node configuration applied': }
}
