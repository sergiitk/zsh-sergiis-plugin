# Sergii's plugin.

ZSH_SERGII="$(dirname $0)"

# Options:
# man zshoptions

# Advaned globbing using ksh patterns,
# see checkdot and checkdotdirs
setopt KSH_GLOB
# Advanced zsh globbing:
# man zshexpn -> FILENAME GENERATION
setopt EXTENDED_GLOB
# Allow passing the unexpanded glob.
setopt NO_NOMATCH

# --- history
# zsh: https://zsh.sourceforge.io/Doc/Release/Options.html#History
# oh my zsh: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh

# History size.
# The maximum number of events stored in the internal history list.
# If you use the HIST_EXPIRE_DUPS_FIRST option, setting this value larger than the SAVEHIST
# size will give you the difference as a cushion for saving duplicated history events.
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-HISTSIZE
export HISTSIZE=16777216  # 16,777,216 == 2^24

# The maximum number of history events to save in the history file.
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-SAVEHIST
export SAVEHIST="${HISTSIZE}"

# Zsh history sharing cross-terminals.
# When SHARE_HISTORY is enabled, it reads and writes to the history file.
# When INC_APPEND_HISTORY is enabled, it only writes to the history file.
setopt SHARE_HISTORY
# setopt INC_APPEND_HISTORY

# Remove superfluous blanks from each command line being added
# to the history list.
setopt HIST_REDUCE_BLANKS

# unset oh-my-zsh
unsetopt HIST_EXPIRE_DUPS_FIRST

# / --- history

source $ZSH_SERGII/universal/zle.zsh
# source $ZSH_SERGII/universal/zle-completions.zsh
source $ZSH_SERGII/universal/aliases.zsh
source $ZSH_SERGII/universal/aliases-git.zsh
source $ZSH_SERGII/universal/functions.zsh

if [[ "$(uname)" == "Darwin" ]]; then
  source $ZSH_SERGII/osx/macports.zsh
  source $ZSH_SERGII/osx/aliases.zsh
  source $ZSH_SERGII/osx/functions.zsh
  # https://github.com/ohmyzsh/ohmyzsh/issues/11416
  # https://github.com/ohmyzsh/ohmyzsh/issues/11454
  compdef _files diff
fi

source $ZSH_SERGII/custom/aliases.zsh
source $ZSH_SERGII/custom/functions.zsh

# zsh-syntax-highlighting settings
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
ZSH_HIGHLIGHT_STYLES[command]='fg=010,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=010,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=010,bold,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=051,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=087'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=087,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=227'
ZSH_HIGHLIGHT_STYLES[assign]='fg=204'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=69,underline'
ZSH_HIGHLIGHT_STYLES[default]='fg=195'
