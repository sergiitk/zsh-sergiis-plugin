# Preload Sergii's plugin.
# Add before sourcing oh-my-zsh:
# if [[ -f "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh" ]]; then
#   source "${ZSH}/custom/plugins/zsh-sergiis-plugin/preload.zsh"
# fi

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
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\"'"

# FZF
export FZF_BASE=/opt/local/share/fzf
export FZF_DEFAULT_OPTS='--layout=reverse --border'
export FZF_COMPLETION_TRIGGER='~~'
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# ? for log line preview window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"


# Because completions is in unusual place
# export DISABLE_FZF_AUTO_COMPLETION='true'
# source /opt/local/share/zsh/site-functions/_fzf
# source /opt/local/share/fzf/shell/completion.zsh

# Tmux
# export ZSH_TMUX_ITERM2=true
# export ZSH_TMUX_FIXTERM=false
# export ZSH_TMUX_FIXTERM_WITHOUT_256COLOR=xterm
# export ZSH_TMUX_FIXTERM_WITH_256COLOR=xterm-256color

# Load local profile
source "${HOME}/.profile"
