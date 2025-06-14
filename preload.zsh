# Preload Sergii's plugin.
# Add before sourcing oh-my-zsh:
# if [[ -f "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh" ]]; then
#   source "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh"
# fi

# omz settings
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Fix word navigation
# When forward-navigation words, don't skip over the last character
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/select-word-style
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/forward-word-match
autoload -U select-word-style
select-word-style bash

### Plugins config

# https://github.com/zsh-users/zsh-autosuggestions#suggestion-highlight-style
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247,bold"

# Use bat instead of colored-man-pages plugin
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\" --pager=\"less --jump-target=10 --status-column\"'"
export DELTA_PAGER="less --jump-target=0"

# FZF
# https://junegunn.github.io/fzf/shell-integration/
export FZF_BASE=/opt/local/share/fzf
export FZF_DEFAULT_OPTS='--layout=reverse --border'

## Keybindings
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

## alt+c
# List directories.
# Disable so escape-c (my common mistake) doesn't start indexing everything.
FZF_ALT_C_COMMAND=""

## ctrl+t
# List directories and files.
# Disable because I don't like it.
FZF_CTRL_T_COMMAND=""

## ctrl+r
# History search.
# Default keybindings:
#   - `ctrl+r` (again) - switch between relevant and cronological order.
# Configured keybinding:
#   - `?` - display long commands in the preview window.
export FZF_CTRL_R_OPTS="--preview='echo {}'\
 --preview-window='down:3:hidden:wrap'\
 --bind='?:toggle-preview,alt-enter:become(echo {q})'\
"

 # --bind='?:toggle-preview,alt-enter:accept-or-print-query'\
# "cd into the selected directory"

# Because completions is in unusual place
# export DISABLE_FZF_AUTO_COMPLETION='true'
# source /opt/local/share/zsh/site-functions/_fzf
# source /opt/local/share/fzf/shell/completion.zsh

# Tmux
# export ZSH_TMUX_ITERM2=true
# export ZSH_TMUX_FIXTERM=false
# export ZSH_TMUX_FIXTERM_WITHOUT_256COLOR=xterm
# export ZSH_TMUX_FIXTERM_WITH_256COLOR=xterm-256color

# omz creates ~/.zcompdump- file that indexes everything prior to load
# add macports fpath for better index
# also this properly inserts it after omz plugin fpaths, but before system
if [[ -v plugins && "${plugins[(ie)macports]}" -le "${#plugins}" ]]; then
  fpath=(/opt/local/share/zsh/site-functions $fpath)
fi

# Use omz custom fpath directory to save generated completions
# md $ZSH_CUSTOM/completions
# uv generate-shell-completion zsh > $ZSH_CUSTOM/completions/_uv

# Load local profile
source "${HOME}/.profile"
