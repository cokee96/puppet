# import 'requisites.pp'

node 'puppet-node.home', 'puppet-node-2.home','puppet-node-3.home','puppet-node-4.home'  {
  include requisites::requisites
}
node default {
  notify { 'Default node configuration applied': }
}
