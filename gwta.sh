#!/usr/bin/env bash

# Check if the argument is provided
if [ -z "$1" ]; then
	echo_info "Usage: $0 <branch_name>"
	exit 1
fi

success=$(tput setaf 34)
reset=$(tput sgr0)

# Capture the original string from the command-line argument
branch_name="$1"

# Replace '/' with '-'
branch_directory=${branch_name//\//-}

echo "Checking branch at remote"

if git worktree add "$branch_directory" "$branch_name" >/dev/null 2>&1; then
	echo "Yeah, so from remote…"
else
	echo "Nope, so from local develop"
	git worktree add -b "$branch_name" "$branch_directory" origin/develop
fi

cd "$branch_directory" || (echo_error "Directory branch doesn't exists: ${branch_directory}" && exit 1)
echo "${success}Wortkree created and you are in it${reset}"
