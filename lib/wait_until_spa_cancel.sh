#!/usr/bin/env bash

elapsed=0
timeout=20

while [ $elapsed -lt $timeout ]; do
	sleep 1
	current_command_in_build=$(tmux display-message -p -t lspa:build.0 '#{pane_current_command}')
	if [ "$current_command_in_build" == 'zsh' ]; then
		break
	fi
	((elapsed++))
done

if ((elapsed >= timeout)); then
	echo_error "Error: Timeout for clearing panes"
	exit 1
fi
