#!/usr/bin/env bash

source /home/rklak/scripts/lib/colors.sh

echo_info "Getting remote branches list"
local_worktree_list=$(git worktree list | grep -v -E 'master|develop|bare')
local_branches=$(echo "$local_worktree_list" | awk '{print $NF}' | sed 's/\[\(.*\)\]/\1/')
remote_branches=$(git ls-remote --heads -q)

for local_branch in $local_branches; do
	if grep -q "$local_branch" <<<"$remote_branches"; then
		echo_warn -n "Removing at remote: " && echo_info "$local_branch"
		git push origin --delete "$local_branch" --no-verify
	else
		echo_info "$local_branch does not exist in remote"
	fi
done

echo_warn "Removing locally"
echo "$local_worktree_list" | cut -f 1 -d ' ' | xargs -I {} git worktree remove -f {}

echo_info "git worktree prune"
git worktree prune

echo_success "Success cleaning"

echo ""
echo_info "Worktree"
git worktree list

echo ""
echo_info "Directory"
exa --long --all --color auto --icons --sort=type

echo ""
echo_success "Good luck!"
