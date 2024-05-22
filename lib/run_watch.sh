#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh
source /home/radoslaw-klak/scripts/lib/functions.sh

working_directory="${1:-$(pwd)}"

guard_switch_to_other_pane "lapi:watch"
guard_pane_is_free "lapi:watch"
guard_npm_run_is_available "$working_directory" "watch"

run_command "npm run watch" "$working_directory" "lapi:watch"

wait_until_watch
