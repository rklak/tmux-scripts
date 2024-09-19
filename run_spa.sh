#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"
source /home/radoslaw-klak/scripts/lib/functions.sh

working_directory="${1:-$(pwd)}"

guard_switch_to_other_pane "lspa:build"
guard_pane_is_free "lspa:build"
guard_npm_run_is_available "$working_directory" "start"

run_command "npm run start" "$working_directory" "lspa:build"

wait_until_spa
