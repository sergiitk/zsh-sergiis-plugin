## Configure apps
## -------------------------------------------------------------------------------------------------

# Use bat instead of colored-man-pages plugin
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\" --pager=\"less --jump-target=10 --status-column\"'"

# Delta compativility with my lesskey
export DELTA_PAGER="less --jump-target=0"

# App completions note:
# Use omz custom fpath directory to save generated completions
#
# md $ZSH_CUSTOM/completions
# uv generate-shell-completion zsh > $ZSH_CUSTOM/completions/_uv
