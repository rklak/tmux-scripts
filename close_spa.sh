#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"
source "$HOME/scripts/lib/functions.sh"

guard_switch_to_other_pane "lspa:build"

abort_command "lspa:build" "npm"

wait_until_spa_cancel
