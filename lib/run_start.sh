#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh
source /home/radoslaw-klak/scripts/lib/functions.sh

working_directory="${1:-$(pwd)}"

guard_switch_to_other_pane "lapi:build"
guard_pane_is_free "lapi:build"
guard_npm_run_is_available "$working_directory" "start"

run_command "npm run start" "$working_directory" "lapi:build"

wait_until_start
