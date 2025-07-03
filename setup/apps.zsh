## Configure apps
## -------------------------------------------------------------------------------------------------
# App completions note:
# Use omz custom fpath directory to save generated completions
#
# md $ZSH_CUSTOM/completions
# uv generate-shell-completion zsh > $ZSH_CUSTOM/completions/_uv
## -------------------------------------------------------------------------------------------------

# Use bat instead of colored-man-pages plugin
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\" --pager=\"less --jump-target=10 --status-column\"'"

# Delta compatibility with my lesskey
export DELTA_PAGER="less --jump-target=0"

# Configure the output format of zsh's `time`
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-TIMEFMT
export TIMEFMT=$'\n"%J" time report:\nreal\t%E\t[%*E]\nuser\t%U\t[%*U]\nsys\t%S\t[%*S]'
