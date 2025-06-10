# import 'nginx_deploy.pp'

node 'puppet-node', 'puppet-node-2','puppet-node-3','puppet-node-4' {
  include example_web::nginx_deploy
}

node default {
  notify { 'Default node configuration applied': }
}
