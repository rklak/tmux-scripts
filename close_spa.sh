#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh
source /home/radoslaw-klak/scripts/lib/functions.sh

guard_switch_to_other_pane "lspa:build"

abort_command "lspa:build" "npm"

wait_until_spa_cancel
