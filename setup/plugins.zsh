## Configure oh-my-zsh and third-party plugins
## -------------------------------------------------------------------------------------------------

## zsh-syntax-highlighting
## https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
## -------------------------------------------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[command]='fg=010,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=010,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=010,bold,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=051,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=087'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=087,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=227'
ZSH_HIGHLIGHT_STYLES[assign]='fg=204'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=69,underline'
ZSH_HIGHLIGHT_STYLES[default]='fg=195'


## fzf-tab
## https://github.com/Aloxaf/fzf-tab/wiki/Configuration
## -------------------------------------------------------------------------------------------------
# Use groups
# zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group ',' '.'

# style
zstyle ':fzf-tab:*' fzf-pad 4
# https://www.mankier.com/1/fzf#Key/Event_Bindings
# zstyle ':fzf-tab:*' fzf-bindings 'enter:accept'

# Accept and run:
zstyle ':fzf-tab:*' accept-line ctrl-space

# Accept printed as is (default)
# zstyle ':fzf-tab:*' print-query alt-right

# git
zstyle ':completion:*:git-checkout:*' sort false

# fzf-tab preview
# https://github.com/Aloxaf/fzf-tab/wiki/Preview
# kill
# zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
# zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
#   '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
# zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
# tldr
# zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
