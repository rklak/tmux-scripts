#!/usr/bin/env bash

elapsed=0
timeout=20

while [ $elapsed -lt $timeout ]; do
	sleep 1
	output=$(tmux capture-pane -p -t lspa:build | sed '/^$/d' | tail -4)
	if [[ $output == *"webpack compiled successfully"* ]]; then
		break
	fi
	((elapsed++))
done

if ((elapsed >= timeout)); then
	echo_error "Error: Timeout for start exceeded"
	exit 1
fi
