#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"

nvm i
npm i
cp .env.dist .env

echo_success "SPA Initialised"
