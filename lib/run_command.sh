#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh

command=$1
working_directory=$2
pane_id=$3

echo -n "Running " && echo_info -n "$command" && echo -n " in " && echo_info "$(basename "$working_directory")"
tmux send-keys -t "${pane_id}" Escape dd i "cd ${working_directory} && ${command}" Enter
