#!/bin/bash

LOCAL_BASE="./puppet"
PUPPET_ENV_DIR="/etc/puppetlabs/code/environments"

# deploylamp / database
mkdir -p "$PUPPET_ENV_DIR/deploylamp/manifests"
mkdir -p "$PUPPET_ENV_DIR/deploylamp/modules/lamp/manifests"
mkdir -p "$PUPPET_ENV_DIR/deploylamp/modules/lamp/templates"

# site.pp va al entorno
cp "$LOCAL_BASE/lamp/site.pp" "$PUPPET_ENV_DIR/deploylamp/manifests/"

# clases y plantillas al módulo
cp "$LOCAL_BASE/lamp/db.pp" "$PUPPET_ENV_DIR/deploylamp/modules/lamp/manifests/"
cp "$LOCAL_BASE/lamp/webapp.pp" "$PUPPET_ENV_DIR/deploylamp/modules/lamp/manifests/"
cp "$LOCAL_BASE/lamp/nodes_email.sql.erb" "$PUPPET_ENV_DIR/deploylamp/modules/lamp/templates/"

# nginx / example_web
mkdir -p "$PUPPET_ENV_DIR/nginx/manifests"
mkdir -p "$PUPPET_ENV_DIR/nginx/modules/example_web/manifests"
mkdir -p "$PUPPET_ENV_DIR/nginx/modules/example_web/templates"

cp "$LOCAL_BASE/nginx/site.pp" "$PUPPET_ENV_DIR/nginx/manifests/"
cp "$LOCAL_BASE/nginx/nginx_deploy.pp" "$PUPPET_ENV_DIR/nginx/modules/example_web/manifests/"
cp "$LOCAL_BASE/nginx/index.html.erb" "$PUPPET_ENV_DIR/nginx/modules/example_web/templates/"

# requisites
mkdir -p "$PUPPET_ENV_DIR/requisites/manifests"
mkdir -p "$PUPPET_ENV_DIR/requisites/modules/requisites/manifests"

cp "$LOCAL_BASE/requisites/site.pp" "$PUPPET_ENV_DIR/requisites/manifests/"
cp "$LOCAL_BASE/requisites/requisites.pp" "$PUPPET_ENV_DIR/requisites/modules/requisites/manifests/"

echo "Copiado completado correctamente."
