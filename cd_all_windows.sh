#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh

# Function to change directory in all tmux panes except the current one
change_directory() {
	local DIR=$1
	local SESSION
	SESSION=$(tmux display-message -p '#S')
	local CURRENT_PANE
	CURRENT_PANE=$(tmux display-message -p '#D')

	tmux list-panes -a -F '#{session_name} #{window_name} #{pane_id}' | while read -r PANE_INFO; do

		local SESSION_NAME
		SESSION_NAME=$(echo "$PANE_INFO" | awk '{print $1}')
		local PANE_ID
		PANE_ID=$(echo "$PANE_INFO" | awk '{print $3}')

		if [[ $SESSION_NAME == "$SESSION" ]] && [[ $PANE_ID != "$CURRENT_PANE" ]]; then
			local WINDOW_NAME
			WINDOW_NAME=$(echo "$PANE_INFO" | awk '{print $2}')
			current_command_in_pane=$(tmux display-message -p -t "$PANE_ID" '#{pane_current_command}')
			if [ "$current_command_in_pane" != "zsh" ]; then
				echo_warn "$(printf "%12s %s\n" "$WINDOW_NAME" "> $current_command_in_pane")"
				continue
			fi
			tmux send-keys -t "$PANE_ID" "cd $DIR" C-m
			sleep 0.02
			local current_pane_path
			current_pane_path=$(tmux display-message -p -t "$PANE_ID" '#{pane_current_path}')

			if [[ "$DIR" != "$current_pane_path" ]]; then
				echo_error "$(printf "%12s %s\n" "$WINDOW_NAME" "error")"
			fi
		fi
	done
}

# Check if the script has received input from a pipe or as an argument
if [ -p /dev/stdin ]; then
	# If data is being piped to the script
	while IFS= read -r LINE; do
		change_directory "$LINE"
	done
else
	# If an argument is provided to the script
	if [ $# -eq 0 ]; then
		echo "Usage: $0 <directory> or echo <directory> | $0"
		exit 1
	else
		change_directory "$1"
	fi
fi
