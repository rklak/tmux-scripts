#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh

working_directory=$1
npm_script=$2
if ! jq ".scripts[\"$npm_script\"]" package.json &>/dev/null; then
	echo_error -n "Command " && echo_info -n "npm run $npm_script" && echo_error -n " is not available in directory " && echo_info "$working_directory"
	exit 1
fi
