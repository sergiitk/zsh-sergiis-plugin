################## Specific aliases  #################
################## OSX-only section  #################

# Global aliases.
# alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'
# alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'
alias pbc='tee >(pbcopy)'

# Finder.
alias lf='l "$(pfd)"'
# Open finder in current dir
alias f="open ${PWD}"
alias o="open"

# Port.
alias pup='sudo port selfupdate && sudo port echo outdated && sudo port upgrade outdated'
alias pca='sudo port -f clean --all all'

# Utils.
alias 'df?'='gdf --si --output=source,used,pcent / | tail -1 | column -t'
