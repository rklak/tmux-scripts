#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"

pane_id="$1"
current_command_in_pane=$(tmux display-message -p -t "$pane_id".0 '#{pane_current_command}')

if [[ "$current_command_in_pane" != "zsh" ]]; then
  echo -n " > "
  echo_warn -n "$current_command_in_pane"
  echo -n " is still running in "
  echo_warn "$pane_id"
  exit 1
fi
