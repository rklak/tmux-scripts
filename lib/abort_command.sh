#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh

pane_id="$1"
command="$2"

current_command_in_pane=$(tmux display-message -p -t "${pane_id}".0 '#{pane_current_command}')

if [[ "$current_command_in_pane" != "zsh" ]]; then
	if [ "$current_command_in_pane" == "$command" ]; then
		echo_warn " > ${command} is still running in ${pane_id}… aborting"
		tmux send-keys -t "${pane_id}" C-C
	else
		echo -n " > "
		echo_warn -n "$current_command_in_pane"
		echo -n " is still running in "
		echo_warn "$pane_id"
		exit 1
	fi
fi
