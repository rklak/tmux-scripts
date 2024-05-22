#!/usr/bin/env bash

if ! declare -F guard_switch_to_other_pane &>/dev/null; then
	guard_switch_to_other_pane() {
		/home/radoslaw-klak/scripts/lib/guard_switch_to_other_pane.sh "$@"

		local exit_code="$?"
		if [ $exit_code -eq 1 ]; then
			exit 1
		fi
	}
fi

if ! declare -F guard_pane_is_free &>/dev/null; then
	guard_pane_is_free() {
		/home/radoslaw-klak/scripts/lib/guard_pane_is_free.sh "$@"

		local exit_code="$?"
		if [ $exit_code -eq 1 ]; then
			exit 1
		fi
	}
fi

if ! declare -F guard_npm_run_is_available &>/dev/null; then
	guard_npm_run_is_available() {
		/home/radoslaw-klak/scripts/lib/quard_npm_run_is_available.sh "$@"

		local exit_code="$?"
		if [ $exit_code -eq 1 ]; then
			exit 1
		fi
	}
fi

if ! declare -F run_command &>/dev/null; then
	run_command() {
		/home/radoslaw-klak/scripts/lib/run_command.sh "$@"
	}
fi

if ! declare -F wait_until_start &>/dev/null; then
	wait_until_start() {
		/home/radoslaw-klak/scripts/lib/wait_until_start.sh
	}
fi

if ! declare -F wait_until_watch &>/dev/null; then
	wait_until_watch() {
		/home/radoslaw-klak/scripts/lib/wait_until_watch.sh
	}
fi

if ! declare -F wait_until_watch_start_cancel &>/dev/null; then
	wait_until_watch_start_cancel() {
		/home/radoslaw-klak/scripts/lib/wait_until_watch_start_cancel.sh
	}
fi

if ! declare -F abort_command &>/dev/null; then
	abort_command() {
		/home/radoslaw-klak/scripts/lib/abort_command.sh "$@"
	}
fi

if ! declare -F wait_until_spa &>/dev/null; then
	wait_until_spa() {
		/home/radoslaw-klak/scripts/lib/wait_until_spa.sh
	}
fi

if ! declare -F wait_until_spa_cancel &>/dev/null; then
	wait_until_spa_cancel() {
		/home/radoslaw-klak/scripts/lib/wait_unitl_spa_cancel.sh
	}
fi
