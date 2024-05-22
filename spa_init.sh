#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh

nvm i
npm i
cp .env.dist .env

echo_success "SPA Initialised"
