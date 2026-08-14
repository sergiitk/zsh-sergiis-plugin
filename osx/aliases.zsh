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

# macos flags and attrs
alias ls-osx-xattr="xattr -l -v"
alias ls-osx-flags="/bin/ls -lFO"
alias stat-osx-flags="stat -f '%Sp  %Su %Sg  %Sf  %R'"
alias osx-hide="chflags hidden"
alias osx-unhide="chflags nohidden"

## Finder
## -------------------------------------------------------------------------------------------------
alias lf='l "$(pfd)"'
# Open finder in current dir
alias f='open "$(pwd)"'
alias o="open"

## MacPorts
## Instead of https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macports,
## uses better MacPort completion from zsh-completions.
#
# [Port useful commands]
#
# Most important: port help
#   port help installed
#   port help info
#
# Installed ports, including install time and requested variants:
# (-v is what gives the full data; -q omits header line)
#   port installed -qv clang-21
#
#
# [Debugging variants]
#
# [+] means the default
# (+) or (-) means variants.conf override (note this takes precedence over [])
# + or - marks means explicitly enabled or disabled when installing with +variant
#
#   port variants info
#   port cat gnupg2 | grep default_variants
#   port info --line --name installed and "variant:openldap"
#   port info --fullname --variants installed and "variant:openldap"
#   port info --line --fullname --variants installed and "variant:openldap"
#   port info installed and "variant:debug" | grep -B1 "Variants:" | column -t -l2
#   port info gnupg2 +openldap
#   port installed -v | grep -F -- '-debug'
#
# Figuring out what got enabled. First, modify variants.conf. Then run:
#   port info installed and "variant:x11" | grep -vF "Sub-ports" | grep -B1 "Variants:" | column -t -l2 > x11.txt
#   grep -B1 -F '[+]x11' x11.txt
#
#
# [Debugging binary distributions (archives)]
#
# Fetch debug information:
# (-d for debug mode; implies -v for verbose)
#   sudo port -d fetch clang-21
#
# Checking the archives:
#   curl -s https://packages.macports.org/llvm-21/ | grep darwin_25
#   html2text -width 120 https://packages.macports.org/llvm-21/ | grep -v rmd160 | grep darwin_25
#   glow https://packages.macports.org/llvm-21/ | grep darwin_25
#   glow https://packages.macports.org/llvm-21/ | grep -oP '.+(darwin_25).+tbz2(?!\.)'
#
## -------------------------------------------------------------------------------------------------

# aliases
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
  sudo port -N upgrade outdated
}

# requested ports that needs $1
port-why() {
  local mode="requested"
  if [[ "${1}" == "--all" ]]; then
    shift
    mode="installed"
  fi
  local -a cmd
  cmd=(port info --line --name "${mode}" and "rdepends:${1}")
  print-cmd "${cmd[@]}"
  ${cmd[@]}

  if (( $? != 0 )); then
    cmd=(port echo requested and "${1}")
    echo
    print-cmd "${cmd[@]}"
    ${cmd[@]}
  fi
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
