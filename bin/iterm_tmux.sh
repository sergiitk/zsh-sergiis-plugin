#!/usr/bin/env zsh
# shellcheck shell=bash
set -euo pipefail

# Tmux tab titles in iTerm2.
# See:
# - https://iterm2.com/documentation-tmux-integration.html
# - https://gitlab.com/gnachman/iterm2/-/wikis/tmux-Integration-Best-Practices

main() {
    local session_name="${1:?"session name (arg 1) is required"}"
    local window_name="${2:?"window name (arg 2) is required"}"

    if (( ! $+commands[tmux] )); then
        print -u2 "Error: tmux is not installed."
        exit 1
    fi


    _echo_log() {
        local log_file=""
        local log_dir="${HOME}/.oh-my-zsh/custom/plugins/zsh-sergiis-plugin/log"
        if [[ ! -d "${log_dir}" ]]; then
            echo "$*"
            return
        fi

        log_file="${log_dir}/iterm_tmux.log"
        echo "[$(date "+%F %T")][${session_name}:${window_name}] $*" | tee -a "${log_file}"
    }


    # 1. Check if the session exists
    if ! tmux has-session -t "${session_name}" 2>/dev/null; then
        # Session does not exist: Create it, name the first window, and attach in Control Mode
        _echo_log "Creating new session '${session_name}' with window '${window_name}'..."
        exec tmux -2 -CC new -s "${session_name}" -n "${window_name}"
    fi

    # 2. Session exists: check if the desired window (tab) exists.
    local -a windows
    windows=( ${(f)"$(tmux list-windows -t "${session_name}" -F '#{window_name}' 2>/dev/null)"} )
    # shellcheck disable=SC1072,SC1073,SC1009
    if (( ! windows[(I)${window_name}] )); then
        # Window does not exist: Create it in the background
        # This causes the running iTerm2 window to instantly pop open a new native tab.
        _echo_log "Creating new window '${window_name}' in session '${session_name}'..."
        exec tmux -CC new-window -t "${session_name}" -n "${window_name}"
    fi

    # Note that window selection doesn't work like that.
    # Maybe we cand do something with https://iterm2.com/documentation-escape-codes.html?

    # 3. Session and window exist:
    # Check if an active iTerm2 client is already attached in Control Mode
    if [[ -n $(tmux list-clients -t "${session_name}" 2>/dev/null) ]]; then
        # Client already attached: Select target window
        _echo_log "WOULD HAVE switched active tab to '${window_name}' in running session '${session_name}'."
        exec tmux -CC select-window -t "${session_name}:${window_name}"
        # sleep 0.5
        exit 0
    fi

    # 4. Session and window exist, but not attached
    _echo_log "WOULD HAVE switched active tab to '${window_name}'."
    tmux select-window -t "${session_name}:${window_name}"

    # Attach
    _echo_log "Attaching to existing session '${session_name}'..."
    exec tmux -2 -CC attach -t "${session_name}"
}

main "$@"
