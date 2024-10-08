#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"

if docker ps --all --format '{{.Names}}' | grep -q .; then
  worktree_catalog=$(docker ps --all --format '{{.Names}}' | grep setup | sed 's/-orca-orchestrator-localstack-setup-1$//' | sed 's/vic/VIC/g')
  echo_info -n "Docker containers are running. Aborting in the worktree: " && echo_warn "$worktree_catalog"
  cd "$HOME/projects/orca-orchestrator/$worktree_catalog" || (echo_error "Directory branch doesn't exists ${worktree_catalog}" && exit 1)
  docker-compose down
fi

if docker ps --all --format '{{.Names}}' | grep -q .; then
  echo_error "Some docker containers are still running:"

  docker ps -all
  exit 1
fi

echo_success "No running Docker containers"
