## The order of .z* files: https://unix.stackexchange.com/a/71258
## (2) .zprofile - login shells, sourced before .zshrc
## -------------------------------------------------------------------------------------------------

# Set as early as possible case zsh loading is interrupted. (defaults 64000 1000)
export HISTSIZE="16777216" SAVEHIST="16777216"
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
