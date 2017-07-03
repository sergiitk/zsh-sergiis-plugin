# Sergii's plugin.

ZSH_SERGII=`dirname $0`

# Advaned globbing using ksh patterns,
# see checkdot and checkdotdirs
setopt kshglob

source $ZSH_SERGII/universal/zle.zsh
source $ZSH_SERGII/universal/aliases.zsh
source $ZSH_SERGII/universal/aliases-git.zsh
source $ZSH_SERGII/universal/functions.zsh

source $ZSH_SERGII/osx/aliases.zsh
source $ZSH_SERGII/osx/aliases-macports.zsh
source $ZSH_SERGII/osx/functions.zsh

source $ZSH_SERGII/custom/aliases.zsh
source $ZSH_SERGII/custom/functions.zsh
