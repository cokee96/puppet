# import 'requisites.pp'

node 'puppet-node', 'puppet-node-2','puppet-node-3','puppet-node-4'  {
  include requisites:requisites
}
node default {
  notify { 'Default node configuration applied': }
}
