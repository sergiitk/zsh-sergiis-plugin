## Preload Sergii's plugin.
# This file is intended for common settings that needs to be configured before zsh.
# Add before sourcing oh-my-zsh:
# if [[ -f "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh" ]]; then
#   source "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh"
# fi
## -------------------------------------------------------------------------------------------------

## omz settings and customiztions
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
# export ZSH_TMUX_ITERM2=true
# export ZSH_TMUX_FIXTERM=false
# export ZSH_TMUX_FIXTERM_WITHOUT_256COLOR=xterm
# export ZSH_TMUX_FIXTERM_WITH_256COLOR=xterm-256color

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
