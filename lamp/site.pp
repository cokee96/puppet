# Carga las clases definidas en los otros archivos del mismo directorio
# import 'webapp.pp'
# import 'database.pp'

node 'puppet-node-2' {
  include lamp::webserver
}

node 'puppet-node-3' {
  include lamp::db
}

node default {
  notify { 'Default node configuration applied': }
}
