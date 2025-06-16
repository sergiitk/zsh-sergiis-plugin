## Configure oh-my-zsh and third-party plugins
## -------------------------------------------------------------------------------------------------

## zsh-syntax-highlighting
## https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
## -------------------------------------------------------------------------------------------------

if [[ -n "${ZSH_HIGHLIGHT_STYLES}" ]]; then
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
fi

## zsh-autosuggestions
## -------------------------------------------------------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247"

## FZF
## https://junegunn.github.io/fzf/shell-integration/
## -------------------------------------------------------------------------------------------------
FZF_DEFAULT_OPTS='--layout=reverse --border'

## Keybindings
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings

# Use ~~ as the trigger sequence instead of the default **
FZF_COMPLETION_TRIGGER='~~'

# alt+c, ctrl+t: see preload.zsh
# they must be loaded before fzf

## ctrl+r
# History search.
# Default keybindings:
#   - `ctrl+r` (again) - switch between relevant and cronological order.
# Configured keybinding:
#   - `?`         - display long commands in the preview window.
#   - `alt-enter` - accept current query as the command.
# Notes:
#   - alt-enter not working in iterm2:
#     profile -> keys -> left option key -> Esc+
#   - alternative - accepts only when no results: accept-or-print-query
FZF_CTRL_R_OPTS=(
  "--preview='echo {}'"
  "--preview-window='down:3:hidden:wrap'"
  "--bind='?:toggle-preview,alt-enter:become(echo {q})'"
)

## fzf-tab
## https://github.com/Aloxaf/fzf-tab/wiki/Configuration
## -------------------------------------------------------------------------------------------------
# zstyle ':completion:*' menu no

#### Popup style
# How many lines does fzf's prompt occupied
zstyle ':fzf-tab:*' fzf-pad 4

#### Enable completion groups
# format info:
# https://zsh.sourceforge.io/Doc/Release/Completion-System.html#index-format_002c-completion-style
zstyle ':completion:*:descriptions' format '[%d]'
# Show the group description even if there's just one group
zstyle ':fzf-tab:*' single-group header
# Switch key binds
zstyle ':fzf-tab:*' switch-group '<' '>'

#### Keybinds
# https://www.mankier.com/1/fzf#Key/Event_Bindings
# zstyle ':fzf-tab:*' fzf-bindings 'enter:accept'

# Accept and run:
zstyle ':fzf-tab:*' accept-line ctrl-space

# Accept printed as is (default)
# zstyle ':fzf-tab:*' print-query alt-right

#### App customization
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

# Completion
# fzf tab can be disabled the following, where `dtf` is the command
# zstyle ':fzf-tab:complete:dtf:*' disabled-on any

# hg - doesn't work for some reason
# zstyle ':fzf-tab:complete:hg:*' disabled-on any
# zstyle ':fzf-tab:complete:hg-*:*' disabled-on any

# zstyle ':fzf-tab:complete:_hg_cmd_*:*' disabled-on any
# zstyle ':fzf-tab:complete:hg-rename:*' disabled-on any
# zstyle ':completion::complete:hg-rename::' _hg_cache_policy

## -------------------------------------------------------------------------------------------------

