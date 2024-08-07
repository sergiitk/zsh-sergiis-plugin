################## Specific aliases  #################
################## OSX-only section  #################

# Global aliases.
# alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'
# alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'
alias pbc='tee >(pbcopy)'

# Finder.
alias lf='l "$(pfd)"'
# Open finder in current dir
alias f='open "$(pwd)"'
alias o="open"

# Port.
# alias pup='sudo port selfupdate \
#   && echo -e "\nRequested and outdated:" \
#   && port echo requested and outdated \
#   && echo -e "\nOutdated:" \
#   && port outdated \
#   && sudo port upgrade outdated'
unalias pup
pup() {
  sudo port selfupdate
  if (( $? != 0 )); then
      return
  fi
  echo
  echo "Outdated:"
  port outdated
  echo
  port echo "Requested and outdated:" requested and outdated
  echo
  sudo port upgrade outdated
}
# alias pca='sudo port -f clean --all all'

# Utils.
alias df/='gdf --si --output=source,used,pcent / | tail -1 | column -t'
