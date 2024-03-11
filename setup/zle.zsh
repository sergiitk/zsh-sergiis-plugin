## Configure Zsh Line Editor (ZLE)
## man zshzle
## -------------------------------------------------------------------------------------------------

# The editor’s idea of a word: controls moves over words.
export WORDCHARS='*?_[]~&;!#$%^(){}<>|@'

# zstyle ':zle:*' skip-whitespace-first true
# zstyle '*' skip-whitespace-first true

# Bind keys.
# Use `read` to read keys, or press ctrl-v then char.
# See infocmp
# ctrl+l Push input
bindkey '^L' push-input

# "^[[5~" page up, "^[[6~" page down
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# Otherwise kills all line
bindkey "^U" backward-kill-line

# Move to where the arguments belong. "^[[1;10D" is shift+option+right.
after-first-word() {
  zle beginning-of-line
  zle forward-word
  zle forward-char
}
zle -N after-first-word
bindkey "^[[1;10D" after-first-word
