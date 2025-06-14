################### Universal Functions  ###################
# List aliases.
# Please make sure GNU version is used: `port echo installed | grep grep`.
ls-alias() {
  # lookahead/begind is used to exclude from coloring
  # before - not a word char or -
  # after - not a word char
  alias | grep -P "(?<![\w-])$argv(?!\w)"
}
alias ls-alias="nocorrect ls-alias"

# List vars.
ls-vars() {
  set | grep -Ev "(_comps|^@|^'\*'|^argv|^_history_substring_|^portlist|_p9k_|^_ZSH_AUTOSUGGEST_BIND_COUNTS)"
  # | grep --color=always -iaF $1
}

# List functions.
ls-func() {
  print -l ${(ok)functions[(I)[^_+-]*]}
}

# Search through all binaries.
ls-bin() {
  CLICOLOR_FORCE=1 ls -l ${^path}/*$1*(N) | awk '{ print $9" "$10" "$11 }'
}

# --- completion ---

ls-comp() {
  print -aC2 ${(kv)_comps}
  # which _hg
  # which $_comps[hg]
  # https://repo.mercurial-scm.org/hg/file/tip/contrib/zsh_completion
}

# reload autocomplete
rl() {
  unfunction $1 && autoload -U $1
}

ls-autoload() {
  print -l ${^fpath}/*$1*(N)
  echo "---------"
  echo "fpath dirs:"
  print -l $fpath
}

# -- files ---

touchx() {
  if [[ $# -ne 1 || -d "$1" ]]; then
    echo "Usage: touchx <file>"
    return
  fi
  touch "$1" && chmod u+x "$1"
}

find-q() {
  find . -not -readable -prune -or "$@" -print
}

# expects GNU find
find-in-dirs() {
  local search_dir="${1:?arg search_dir must be set}"
  local dir_pattern="${2:?arg dir_pattern must be set}"
  find "${search_dir}" -name "${dir_pattern}" -type d -print0 | find -files0-from - -type f "${@:3}" | sort | uniq
}
alias find-in-dirs='noglob find-in-dirs'

function tmp() {
  local prefix
  prefix="${USER}-$(date +%F)"
  # TODO(sergiitk): compatibility with non-bsd mktemp
  cd "$(mktemp -d -t "${prefix}")"
}

ff-luf() {
  ffmpeg -i "$1" -hide_banner -af "loudnorm=I=-19:dual_mono=true:TP=-1.5:LRA=11:print_format=summary" -f null -
}

############ Other utilities.
# Show oh-my-zsh changes.
oh-my-changes() {
  if [[ -z $1 ]]; then
    echo "Commits to inspect, eg. b51c2a0..61e3951"
    return
  fi
  local plugins_changed
  plugins_changed=$(comm -12 <(git --git-dir=$ZSH/.git diff --name-only $1 -- plugins | cut -d/ -f2 | sort -u) <(print -l $plugins | sort -u))
  if [[ -z $plugins_changed ]]; then
    print "\e[32mNothing new.\e[0m"
    return
  fi
  git --git-dir=$ZSH/.git diff -U0 --abbrev --color-words $1 -- plugins/${^${(f)plugins_changed}}
}

# Check dot files.
checkdot() {
  local -a dotfile_allow=(
    CFUserTextEncoding
    curlrc
    DS_Store
    gitconfig
    gitignore_global
    hgrc
    hushlogin
    lesshst
    mysql_history
    npmrc
    profile
    psql_history
    python_history
    sqlite_history
    viminfo
    vimrc
    wget-hsts
    wgetrc
    work-custom.zshrc
    zcompdump*
    zlogin
    zsh-update
    zsh_history
    zshrc
    zshrc.orig
  )
  local dotfile_join="${(j:|:)dotfile_allow}"
  print -l  ~/.!($~dotfile_join)(.N)
}

# Check dot files.
checkdotdirs() {
  local -a dotdir_allow=(
    android
    bin
    cache
    config
    cups
    docker
    gem
    gradle
    gsutil
    heroku
    kube
    m2
    minikube
    npm
    oh-my-zsh
    ssh
    Trash
    vim
  )
  local dotdir_join="${(j:|:)dotdir_allow}"
  print -l  ~/.!($~dotdir_join)(/N)
}

gdu.() {
  _ echo -n $PWD": "
  _ gdu --si --summarize --total --threshold=10m *(/ND^@^F) | gsort -h -r | column -t -s$'\t'
}

cmn() {
  local result=""
  for i in $@
  do
      result="${result} \$${i} \" \""
  done
  # echo $result
  awk "{ print ${result} }" - | column -t
}

siege-to-spreadsheet() {
  local result=""
  result=$(pbpaste | cut -d":" -f2 | awk {'print $1'} | xargs -n1 -I{} printf '{}\t' | sed 's/;$//')
  echo -n $result | pbcopy
  echo $result
}

alias make="nocorrect make"

# base conversion math
dec2hex() {
  printf '%x\n' ${@}
}

hex2dec() {
  for i in $@
  do
    echo $((16#$i))
  done
}

dec2bin() {
  for i in $@
  do
    echo "obase=2; ${i}" | bc
  done
}

bin2dec() {
  for i in $@
  do
    echo $((2#$i))
  done
}
