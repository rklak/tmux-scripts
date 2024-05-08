#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh
source /home/rklak/scripts/lib/functions.sh

guard_switch_to_other_pane "lapi:build|lapi:watch"

abort_command "lapi:watch" "npm"
abort_command "lapi:build" "npm"

wait_until_watch_start_cancel
