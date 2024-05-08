#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh
source /home/rklak/scripts/lib/functions.sh

guard_switch_to_other_pane "lspa:build"

abort_command "lspa:build" "npm"

wait_until_spa_cancel
