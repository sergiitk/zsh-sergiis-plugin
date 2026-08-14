## Preload Sergii's plugin.
## This file is intended for common settings that needs to be configured before zsh.
#
# Add before sourcing oh-my-zsh:
#
# if [[ -f "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh" ]]; then
#   source "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh"
# fi
## -------------------------------------------------------------------------------------------------

## omz settings and customizations
## -------------------------------------------------------------------------------------------------
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes


## FZF
## These must be set before sourcing fzf, the reset in plugins.zsh
## -------------------------------------------------------------------------------------------------

## alt+c - list directories.
# Disable so escape-c (my common mistake) doesn't start indexing everything.
FZF_ALT_C_COMMAND=""

## ctrl+t - list directories and files.
# Disable because I don't like it.
FZF_CTRL_T_COMMAND=""

## Tmux
## -------------------------------------------------------------------------------------------------

# If running inside tmux, re-export TERM_PROGRAM and TERM_PROGRAM_VERSION. Must be in .tmux.conf:
# set -ga update-environment " TERM_PROGRAM TERM_PROGRAM_VERSION"
() {
  if [[ -n "${TMUX}" ]]; then
    local tmux_env_term_program tmux_env_term_program_version
    tmux_env_term_program="$(tmux show-environment TERM_PROGRAM 2> /dev/null | cut -d'=' -f 2)"
    if [[ -z "${tmux_env_term_program}" ]]; then
      return
    fi
    export TERM_PROGRAM="${tmux_env_term_program}"

    tmux_env_term_program="$(tmux show-environment TERM_PROGRAM_VERSION 2> /dev/null | cut -d'=' -f 2)"
    if [[ -n "${tmux_env_term_program}" ]]; then
      export TERM_PROGRAM_VERSION="${tmux_env_term_program}"
    fi
  fi
}


## My customizations
## -------------------------------------------------------------------------------------------------
# omz creates ~/.zcompdump- file that indexes everything prior to load
# add macports fpath for better index
# also this properly inserts it after omz plugin fpaths, but before system
if [[ "${OSTYPE}" == darwin* ]]; then
  fpath=(/opt/local/share/zsh/site-functions $fpath)
fi

# Load local profile
source "${HOME}/.profile"
