#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh

elapsed=0
timeout=20

while [ $elapsed -lt $timeout ]; do
	sleep 1
	output=$(tmux capture-pane -p -t lapi:watch | sed '/^$/d' | tail -2)
	if [[ $output == *"Watching for file changes"* ]]; then
		break
	fi
	((elapsed++))
done

if ((elapsed >= timeout)); then
	echo "Error: Timeout for watch exceeded"
	exit 1
fi
