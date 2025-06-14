## Sergii's plugin.
## -------------------------------------------------------------------------------------------------
ZSH_SERGII="$(dirname $0)"

## Options
## man zshoptions
## -------------------------------------------------------------------------------------------------
unsetopt BEEP

# Advaned globbing using ksh patterns,
# see checkdot and checkdotdirs
setopt KSH_GLOB
# Advanced zsh globbing:
# man zshexpn -> FILENAME GENERATION
setopt EXTENDED_GLOB
# Allow passing the unexpanded glob.
setopt NO_NOMATCH

## history
## zsh: https://zsh.sourceforge.io/Doc/Release/Options.html#History
## oh my zsh: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
## -------------------------------------------------------------------------------------------------

# History size.
# The maximum number of events stored in the internal history list.
# If you use the HIST_EXPIRE_DUPS_FIRST option, setting this value larger than the SAVEHIST
# size will give you the difference as a cushion for saving duplicated history events.
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-HISTSIZE
export HISTSIZE=16777216  # 16,777,216 == 2^24

# The maximum number of history events to save in the history file.
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-SAVEHIST
export SAVEHIST="${HISTSIZE}"

# Unset oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
unsetopt HIST_EXPIRE_DUPS_FIRST

# Save each command’s beginning timestamp.
# Just in case, normally is set by oh-my-zsh.
setopt EXTENDED_HISTORY

# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS

# Zsh history sharing cross-terminals. These options are mutuarlly exclusive.

# Load new commands to the history, but only save them on shell exist.
# setopt SHARE_HISTORY
unsetopt SHARE_HISTORY

# New history lines are added incrementally (as soon as they are entered),
# rather than waiting until the shell exits.
# setopt INC_APPEND_HISTORY
unsetopt INC_APPEND_HISTORY

# Same as INC_APPEND_HISTORY, except written after the command is after the command is finished
# to record elapsed time correctly.
setopt INC_APPEND_HISTORY_TIME

## Imports
## -------------------------------------------------------------------------------------------------
source $ZSH_SERGII/setup/zle.zsh
source $ZSH_SERGII/setup/plugins.zsh
source $ZSH_SERGII/setup/apps.zsh

# source $ZSH_SERGII/universal/zle-completions.zsh
source $ZSH_SERGII/universal/aliases.zsh
source $ZSH_SERGII/universal/aliases-git.zsh
source $ZSH_SERGII/universal/functions.zsh

if [[ "${OSTYPE}" == darwin* ]]; then
  source $ZSH_SERGII/osx/aliases.zsh
  source $ZSH_SERGII/osx/functions.zsh
  # https://github.com/ohmyzsh/ohmyzsh/issues/11416
  # https://github.com/ohmyzsh/ohmyzsh/issues/11454
  compdef _files diff
fi

source $ZSH_SERGII/custom/aliases.zsh
source $ZSH_SERGII/custom/functions.zsh
