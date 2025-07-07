## OSX-specific aliases
## -------------------------------------------------------------------------------------------------

# print and copy
alias pbc='tee >(pbcopy)'
# alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'
# alias -g pbc='head -c-1 | > >(pbcopy) > >(cat) && echo'

# root partition usage
alias df/='gdf --si --output=source,used,pcent / | tail -1 | column -t'

# turn off quaranteen
alias quarantine-off="xattr -rd com.apple.quarantine"

## Finder
## -------------------------------------------------------------------------------------------------
alias lf='l "$(pfd)"'
# Open finder in current dir
alias f='open "$(pwd)"'
alias o="open"

## Macports
## Instead of https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macports,
## uses better macports completion from zsh-completions.
## -------------------------------------------------------------------------------------------------
alias pi='sudo port install'
alias pu='sudo port uninstall'
alias puni="sudo port uninstall inactive"
alias pul='sudo port uninstall leaves'
alias pei='port echo installed'
alias per='port echo requested'

pup() {
  sudo port selfupdate
  if (( $? != 0 )); then
      return
  fi
  echo
  # echo "Outdated:"
  port outdated
  echo
  port echo "Requested and outdated:" requested and outdated
  echo
  sudo port upgrade outdated
}

## Sublime
## -------------------------------------------------------------------------------------------------
alias st='subl'

# shellcheck disable=SC1073,SC1009
cds() {
  local clip file dir
  clip="$(pbpaste)"
  {
    file="$(subl --command 'side_bar_copy_path' --background && sleep 0.1 && pbpaste)"
    if [[  ! -f "${file}" ]]; then
      print -u2 -- "Not a file: ${file}"
      return 1
    fi
    # echo "${file}"
    dir="$(dirname $file)"
    if [[  ! -d "${dir}" ]]; then
      print -u2 -- "Not a dir: ${dir}"
      return 1
    fi
    # echo "${dir}"
    cd "${dir}"
  } always {
    # echo "restoring clipboard: ${clip}"
    echo -e "${clip}" | pbcopy
  }
}
