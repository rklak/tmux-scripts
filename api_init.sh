#!/bin/bash

source /home/rklak/scripts/lib/colors.sh

./init.sh

echo_info "Local override…"

echo_info -n ".env" && echo " set RESTORE_DB_FROM_DUMP_FILE=true"
sed --in-place='' 's/RESTORE_DB_FROM_DUMP_FILE=false/RESTORE_DB_FROM_DUMP_FILE=true/' .env

echo_info -n "docker-compose.override.yml" && echo " keycloak image overwriting"
sed --in-place='' 's/sleighzy\/keycloak:16.1.0-arm64/jboss\/keycloak:10.0.2/' docker-compose.override.yml

# echo_infot "ensure build owner"
# owner_build=$(stat -c "%U" build)
# if [[ "$owner_build" != "rklak" ]]; then
# 	echo_info -n "Build catalog has wrong owner. Changing from " && echo_error -n "$owner_build" && echo_info " to rklak…"
# 	sudo chown rklak build
# else
# 	echo_info "Build catalog already with rklak owner"
# fi

echo_success "Local override ready! Lets jump in!"
