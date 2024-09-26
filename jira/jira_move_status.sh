#!/usr/bin/env bash

source "$HOME/scripts/lib/colors.sh"
source "$HOME/scripts/worktree/git_jira_issue.sh"

issue=$(git_jira_issue)

if [[ -z $issue ]]; then
  echo_warn "Can't find issue, aborting"
  exit 1
fi

jira issue move ${issue}
