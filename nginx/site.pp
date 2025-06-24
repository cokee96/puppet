# import 'nginx_deploy.pp'

node 'puppet-node.home', 'puppet-node-2.home','puppet-node-3.home','puppet-node-4.home' {
  include example_web::nginx_deploy
}

node default {
  notify { 'Default node configuration applied': }
}
