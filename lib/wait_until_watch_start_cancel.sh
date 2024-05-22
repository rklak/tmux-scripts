#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh

elapsed=0
timeout=20

if [[ "$current_command_in_build" != "zsh" || "$current_command_in_watch" != "zsh" ]]; then
	while [ $elapsed -lt $timeout ]; do
		sleep 1
		current_command_in_watch=$(tmux display-message -p -t lapi:watch.0 '#{pane_current_command}')
		current_command_in_build=$(tmux display-message -p -t lapi:build.0 '#{pane_current_command}')
		if [ "$current_command_in_watch" == "zsh" ] && [ "$current_command_in_build" == 'zsh' ]; then
			echo_success "Panes are clear"
			break
		fi
		((elapsed++))
	done

	if ((elapsed >= timeout)); then
		echo_error "Timeout for clearing panes"
		exit 1
	fi
else
	echo_success "Panes are clear"
fi
