#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh

elapsed=0
timeout=10

while [ $elapsed -lt $timeout ]; do
	sleep 1
	output=$(tmux capture-pane -p -t lapi:build | tail -n 5)
	if [[ $output == *"listening"* ]] || [[ $output == *"Attaching to api"* ]]; then
		break
	fi

	((elapsed++))
done

if ((elapsed >= timeout)); then
	echo_error "Error: Timeout for start exceeded"
	exit 1
fi
