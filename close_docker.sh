#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh

if docker ps --all --format '{{.Names}}' | grep -q .; then
	worktree_catalog=$(docker ps --all --format '{{.Names}}' | grep postgres-1 | grep -v keycloak | sed 's/-postgres-1$//' | sed 's/tli/TLI/g')
	echo_info -n "Docker containers are running. Aborting in the worktree: " && echo_warn "$worktree_catalog"
	cd "/home/radoslaw-klak/projects/api/$worktree_catalog" || (echo_error "Directory branch doesn't exists ${worktree_catalog}" && exit 1)
	docker-compose down
fi

if docker ps --all --format '{{.Names}}' | grep -q .; then
	worktree_catalog=$(docker ps -all --format '{{.Names}}' | grep adminer-1 | grep -v keycloak | sed 's/-adminer-1$//' | sed 's/tli/TLI/g')
	echo_info -n "Docker containers are running. Aborting in the worktree: " && echo_warn "$worktree_catalog"
	cd "/home/radoslaw-klak/projects/api/$worktree_catalog" || (echo_error "Directory branch doesn't exists: ${worktree_catalog}" && exit 1)

	docker-compose down
fi

if docker ps --all --format '{{.Names}}' | grep -q .; then
	echo_error "Some docker containers are still running:"

	docker ps -all
	exit 1
fi

echo_success "No running Docker containers"
