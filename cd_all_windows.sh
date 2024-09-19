#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"

# Function to change directory in all tmux panes except the current one
change_directory() {
  local DIR=$1
  local DIR_LOWER
  local SESSION
  local CURRENT_PANE

  SESSION=$(tmux display-message -p '#S')
  CURRENT_PANE=$(tmux display-message -p '#D')
  DIR_LOWER=$(echo $DIR | tr '[:upper:]' '[:lower:]')

  # loop over pane from curren session
  tmux list-panes -a -F '#{session_name} #{window_name} #{pane_id}' | while read -r PANE_INFO; do

    local SESSION_NAME
    local PANE_ID

    SESSION_NAME=$(echo "$PANE_INFO" | awk '{print $1}')
    PANE_ID=$(echo "$PANE_INFO" | awk '{print $3}')

    # exclude current pane
    if [[ $SESSION_NAME == "$SESSION" ]] && [[ $PANE_ID != "$CURRENT_PANE" ]]; then
      local WINDOW_NAME
      local current_command_in_pane

      WINDOW_NAME=$(echo "$PANE_INFO" | awk '{print $2}')
      current_command_in_pane=$(tmux display-message -p -t "$PANE_ID" '#{pane_current_command}')

      # exclude when pane has runnig process
      if [ "$current_command_in_pane" != "zsh" ]; then
        echo_warn "$(printf "%12s %s\n" "$WINDOW_NAME" "> $current_command_in_pane")"
        continue
      fi

      # CHANGE DIR
      tmux send-keys -t "$PANE_ID" "cd $DIR" C-m
      sleep 0.02

      local current_pane_path
      local current_pane_path_lower

      current_pane_path=$(tmux display-message -p -t "$PANE_ID" '#{pane_current_path}')
      current_pane_path_lower=$(echo $current_pane_path | tr '[:upper:]' '[:lower:]')

      # verify lowercased paths
      if [[ "$DIR_LOWER" != "$current_pane_path_lower" ]]; then
        echo_error "$(printf "%12s %s\n" "$DIR_LOWER" "error - still $current_pane_path_lower but should $DIR_LOWER")"
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
