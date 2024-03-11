## The order of .z* files: https://unix.stackexchange.com/a/71258
## (2) .zprofile - login shells, sourced before .zshrc
## -------------------------------------------------------------------------------------------------

# Set as early as possible case zsh loading is interrupted. (defaults 64000 1000)
export HISTSIZE="16777216" SAVEHIST="16777216"
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# https://github.com/rbenv/rbenv/issues/369#issuecomment-36010083
# System-wide .profile for sh(1)
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# MacPorts Installer addition on 2021-01-21_at_11:32:34: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2021-01-21_at_11:32:34: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.
