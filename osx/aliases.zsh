################## Specific aliases  #################
################## OSX-only section  #################

# Global aliases.
alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'

# Finder.
alias lf='l "$(pfd)"'
# Open finder in current dir
alias f="open ${PWD}"

# Port.
alias pca='sudo port -f clean --all all'

# Utils.
alias 'df?'='gdf --si --output=source,used,pcent / | tail -1 | column -t'
