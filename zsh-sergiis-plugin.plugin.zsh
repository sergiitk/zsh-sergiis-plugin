# Sergii's plugin.

ZSH_SERGII="$(dirname $0)"

# Advaned globbing using ksh patterns,
# see checkdot and checkdotdirs
setopt kshglob
# Advanced zsh globbing:
# man zshexpn -> FILENAME GENERATION
setopt EXTENDED_GLOB

# Zsh history sharing cross-terminals.
# When share_history is enabled, it reads and writes to the history file.
# When inc_append_history is enabled, it only writes to the history file.
# setopt inc_append_history
setopt share_history

# History size.
# The maximum number of events stored in the internal history list.
# If you use the HIST_EXPIRE_DUPS_FIRST option, setting this value larger than the SAVEHIST
# size will give you the difference as a cushion for saving duplicated history events.
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-HISTSIZE
export HISTSIZE=16777216  # 16,777,216 == 2^24

# The maximum number of history events to save in the history file.
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-SAVEHIST
export SAVEHIST="${HISTSIZE}"

source $ZSH_SERGII/universal/zle.zsh
# source $ZSH_SERGII/universal/zle-completions.zsh
source $ZSH_SERGII/universal/aliases.zsh
source $ZSH_SERGII/universal/aliases-git.zsh
source $ZSH_SERGII/universal/functions.zsh

if [[ "$(uname)" == "Darwin" ]]; then
  source $ZSH_SERGII/osx/aliases.zsh
  source $ZSH_SERGII/osx/aliases-macports.zsh
  source $ZSH_SERGII/osx/functions.zsh
fi

source $ZSH_SERGII/custom/aliases.zsh
source $ZSH_SERGII/custom/functions.zsh
