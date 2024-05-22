#!/usr/bin/env bash

source /home/radoslaw-klak/scripts/lib/colors.sh

current_branch=$(git rev-parse --abbrev-ref HEAD)

issue_regex="[a-zA-Z]+-[0-9]+"

issue=""
if [[ $current_branch =~ $issue_regex ]]; then
	issue="${BASH_REMATCH[0]}"
fi

if [[ -z $issue ]]; then
	echo_warn "Can't find issue, aborting"
	exit 1
fi

commit_msg=""

# first argument as an issue
if [ $# -gt 0 ]; then
	commit_msg="$1($issue): "
fi

if [[ -z $commit_msg ]]; then
	branch_type_regex="(.*)\/"
	branch_type=""
	if [[ $current_branch =~ $branch_type_regex ]]; then
		branch_type="${BASH_REMATCH[1]}"
	fi

	if [[ -z $branch_type ]]; then
		echo_warn "Can't find branch type, aborting"
		exit 1
	fi

	case $branch_type in
	"feature")
		commit_msg="feat($issue): "
		;;
	"bugfix")
		commit_msg="fix($issue): "
		;;
	"hotfix")
		commit_msg="fix($issue): "
		;;
	*)
		echo_warn "It's something else"
		exit 1
		;;
	esac
fi

tmux send-keys "gcam \"$commit_msg\" " Escape C-h i
tput cr
