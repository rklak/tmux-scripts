#!/usr/bin/env bash

if ! declare -F git_jira_issue &>/dev/null; then
  git_jira_issue() {
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    local issue_regex="[a-zA-Z]+-[0-9]+"

    local issue=""
    if [[ $current_branch =~ $issue_regex ]]; then
      issue="${BASH_REMATCH[0]}"
    fi

    echo "${issue}"
  }
fi
