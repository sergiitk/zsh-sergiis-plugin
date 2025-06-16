## Preload Sergii's plugin.
## Add before sourcing oh-my-zsh:
# if [[ -f "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh" ]]; then
#   source "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh"
# fi

## omz settings and customiztions
## -------------------------------------------------------------------------------------------------

# Gnu ls
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes

# Fix word navigation
# When forward-navigation words, don't skip over the last character
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/select-word-style
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/forward-word-match
autoload -U select-word-style
select-word-style bash

## Apps and plugins
## -------------------------------------------------------------------------------------------------

# Use bat instead of colored-man-pages plugin
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\" --pager=\"less --jump-target=10 --status-column\"'"
export DELTA_PAGER="less --jump-target=0"

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

## My
## -------------------------------------------------------------------------------------------------
# omz creates ~/.zcompdump- file that indexes everything prior to load
# add macports fpath for better index
# also this properly inserts it after omz plugin fpaths, but before system
if [[ "${OSTYPE}" == darwin* ]]; then
  fpath=(/opt/local/share/zsh/site-functions $fpath)
fi

# Use omz custom fpath directory to save generated completions
# md $ZSH_CUSTOM/completions
# uv generate-shell-completion zsh > $ZSH_CUSTOM/completions/_uv

# Load local profile
source "${HOME}/.profile"
