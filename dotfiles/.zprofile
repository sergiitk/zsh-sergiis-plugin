## The order of .z* files: https://unix.stackexchange.com/a/71258
## (2) .zprofile - login shells, sourced before .zshrc
## -------------------------------------------------------------------------------------------------

# Set as early as possible case zsh loading is interrupted. (defaults 64000 1000)
export HISTSIZE="16777216" SAVEHIST="16777216"
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# System-wide .profile for sh(1)
if [ -f /etc/profile ]; then
    # https://github.com/rbenv/rbenv/issues/369#issuecomment-36010083
    # PATH reset was previously used to dedup things, I'll typeset -U later instead.
    # PATH=""
    source /etc/profile
fi
