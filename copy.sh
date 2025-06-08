#!/bin/bash

LOCAL_BASE="./puppet"
PUPPET_ENV_DIR="/etc/puppetlabs/code/environments"

# deploylamp / database
mkdir -p "$PUPPET_ENV_DIR/deploylamp/modules/database/manifests"
mkdir -p "$PUPPET_ENV_DIR/deploylamp/modules/database/templates"
cp "$LOCAL_BASE/lamp/database.pp" "$PUPPET_ENV_DIR/deploylamp/modules/database/manifests/"
cp "$LOCAL_BASE/lamp/webapp.pp" "$PUPPET_ENV_DIR/deploylamp/modules/database/manifests/"
cp "$LOCAL_BASE/lamp/site.pp" "$PUPPET_ENV_DIR/deploylamp/modules/database/manifests/"
cp "$LOCAL_BASE/lamp/nodes_email.sql.erb" "$PUPPET_ENV_DIR/deploylamp/modules/database/templates/"

# nginx / example_web
mkdir -p "$PUPPET_ENV_DIR/nginx/modules/example_web/manifests"
mkdir -p "$PUPPET_ENV_DIR/nginx/modules/example_web/templates"
cp "$LOCAL_BASE/nginx/nginx_deploy.pp" "$PUPPET_ENV_DIR/nginx/modules/example_web/manifests/"
cp "$LOCAL_BASE/nginx/site.pp" "$PUPPET_ENV_DIR/nginx/modules/example_web/manifests/"
cp "$LOCAL_BASE/nginx/index.html.erb" "$PUPPET_ENV_DIR/nginx/modules/example_web/templates/"

# requisites
mkdir -p "$PUPPET_ENV_DIR/requisites/modules/requisites/manifests"
cp "$LOCAL_BASE/requisites/requisites.pp" "$PUPPET_ENV_DIR/requisites/modules/requisites/manifests/"
cp "$LOCAL_BASE/requisites/site.pp" "$PUPPET_ENV_DIR/requisites/modules/requisites/manifests/"

echo "Copiado completado."
