####################### ZSH/ZLE #####################

# ZLE: The editor’s idea of a word: controls moves over words.
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>|'
# Colorize correction request.
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color (Yes, No, Abort, Edit)? "
# Colorize stderr. I don't know how it works, but it's awesome!
# exec 2>>( while read X; do print "\e[48;5;236m"${X}$reset_color > /dev/tty; done & )

# Pass grep color to less.
# export GREP_OPTIONS="--color=always"
# Temp
unset GREP_OPTIONS

# Bind keys.
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey "^U" backward-kill-line
bindkey '^L' push-input

# Opts.
setopt nobeep

# Move to where the arguments belong. "^[[1;10D" is shift+option+right.
after-first-word() {
  zle beginning-of-line
  zle forward-word
}
zle -N after-first-word
bindkey "^[[1;10D" after-first-word
