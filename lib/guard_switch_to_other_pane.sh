#!/usr/bin/env bash

source /home/rklak/scripts//lib/colors.sh

pane_id="$1" # NOTE: example: "lapi:build"
current_pane_id=$(tmux display -p "#{session_name}:#{window_name}")
if [[ "$current_pane_id" =~ ^($pane_id)$ ]]; then
	echo_error "Swtich to other pane"
	exit 1
fi
