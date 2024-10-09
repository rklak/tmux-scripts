#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"

# Check if the argument is provided
if [ -z "$1" ]; then
  echo_info "Usage: $0 <branch_name>"
  exit 1
fi

# Capture the original string from the command-line argument
branch_name="$1"

# Replace '/' with '-'
branch_directory=${branch_name//\//-}

if git worktree add "$branch_directory" "$branch_name" >/dev/null 2>&1; then
  echo "📡 Found on a remote"
else
  branch_main=""
  if [ $(git branch --list develop) ]; then
    branch_main="develop"
  else
    branch_main="master"
  fi

  echo "🚀 Creating from origin/$branch_main"
  git worktree add -b "$branch_name" "$branch_directory" origin/"$branch_main" >/dev/null 2>&1
fi

cd "$branch_directory" || (echo_error "💥 Directory branch doesn't exists: ${branch_directory}" && exit 1)
echo_success "🚧 Wortkree created and you are in it"
