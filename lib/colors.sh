#!/usr/bin/env bash

# if ! declare -F echo_success &>/dev/null; then

# Colors
error=$(tput setaf 160)
info=$(tput setaf 44)
warn=$(tput setaf 214)
success=$(tput setaf 34)
bold=$(tput bold)

# Reset
reset=$(tput sgr0)

echo_info() {
  local newline_arg="" # Initialize a variable to store the newline argument
  if [[ $1 == "-n" ]]; then
    newline_arg="-n" # Set newline_arg to "-n" if the first argument is "-n"
    shift            # Shift the arguments to remove the first argument ("-n")
  fi
  echo $newline_arg "${info}$@${reset}"
}

echo_warn() {
  local newline_arg="" # Initialize a variable to store the newline argument
  if [[ $1 == "-n" ]]; then
    newline_arg="-n" # Set newline_arg to "-n" if the first argument is "-n"
    shift            # Shift the arguments to remove the first argument ("-n")
  fi
  echo $newline_arg "${warn}$@${reset}"
}

echo_error() {
  local newline_arg="" # Initialize a variable to store the newline argument
  if [[ $1 == "-n" ]]; then
    newline_arg="-n" # Set newline_arg to "-n" if the first argument is "-n"
    shift            # Shift the arguments to remove the first argument ("-n")
  fi
  echo $newline_arg "${bold}${error}$@${reset}"
}

echo_success() {
  local newline_arg="" # Initialize a variable to store the newline argument
  if [[ $1 == "-n" ]]; then
    newline_arg="-n" # Set newline_arg to "-n" if the first argument is "-n"
    shift            # Shift the arguments to remove the first argument ("-n")
  fi
  echo $newline_arg "${success}$@${reset}"
}
# fi
