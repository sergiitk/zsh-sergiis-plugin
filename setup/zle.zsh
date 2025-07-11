## Configure Zsh Line Editor (ZLE)
## man zshzle
## https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
## -------------------------------------------------------------------------------------------------

## Word navigation
## -------------------------------------------------------------------------------------------------
# The editor’s idea of a word: controls moves over words.
export WORDCHARS='*?_[]~&;!#$%^(){}<>|@'

# Fix word navigation
# When forward-navigation words, don't skip over the last character
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/select-word-style
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/forward-word-match
# zstyle ':zle:*' skip-whitespace-first true
# zstyle '*' skip-whitespace-first true
autoload -U select-word-style
select-word-style bash

## Bind keys.
## omz bindings: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
## -------------------------------------------------------------------------------------------------
# Useful bindings
# esc+m copy prev shell word
# esc+h push command to stack, run man for it
# esc+? push command to stack, run which-command for it
# makes it same as ?
alias which-command='?'
# alias which-command='whence -asvf'

# Use `read` to read keys, or press ctrl-v then char.
# See infocmp
# ctrl+l Push input
bindkey '^L' push-input

# "^[[5~" page up, "^[[6~" page down
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# Otherwise kills all line
bindkey "^U" backward-kill-line

# Normally omz sets Edit command in EDITOR: ctrl+x+e
# Overrides default zsh "^[/" _history-complete-older
bindkey "^[/" edit-command-line

# Move to where the arguments belong. "^[[1;10D" is shift+option+right.
after-first-word() {
  zle beginning-of-line
  zle forward-word
  zle forward-char
}
zle -N after-first-word
bindkey "^[[1;10D" after-first-word


## p10k shell
## -------------------------------------------------------------------------------------------------
# https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#extra-space-without-background-on-the-right-side-of-right-prompt
# I think with ZLE_RPROMPT_INDENT=1 iterm pane redraw breaks on open/close right.
ZLE_RPROMPT_INDENT=1

## zsh-syntax-highlighting
## https://github.com/zsh-users/zsh-syntax-highlighting
## -------------------------------------------------------------------------------------------------
# debugging:
# zstyle -L ':bracketed-paste-magic'
# zle -lL self-insert

# note for future bracket paste issues:
# https://gitlab.com/gnachman/iterm2/-/wikis/Paste-Bracketing

# Only needed when DISABLE_MAGIC_FUNCTIONS is NOT set.
# Magic functions "fix" url pasting, but make syntax highlight slow.
if (( ${+functions[url-quote-magic]} )); then
  # Fix slowness of pastes with zsh-syntax-highlighting.zsh
  # https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
  #
  # https://github.com/zsh-users/zsh-syntax-highlighting/issues/295
  # https://github.com/zsh-users/zsh-autosuggestions/issues/141
  # ^ probably affects it too
  pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
  }
  pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
  }
  zstyle :bracketed-paste-magic paste-init pasteinit
  zstyle :bracketed-paste-magic paste-finish pastefinish
fi
