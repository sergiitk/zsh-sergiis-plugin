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

# -- directories ---
# print realpath but respecting dir hash tables
rpd() {
  local target_path="${1:?arg1 target_path must be set}"
  if [[ ! -e "${target_path}" ]]; then
    print-warning "${target_path} does not exist"
  fi

  # For symlinks, we'll also print the path without resolving first.
  # Note that this presumes we're using GNU realpath.
  if [[ -L "$target_path" ]]; then
    local real_path_symlink
    real_path_symlink="$(realpath --strip ${target_path})"
    print -n -- "${fg_bold[cyan]}"
    print -nD -- "${real_path_symlink}"
    print -n -- "${reset_color} -> "
  fi

  local real_path
  real_path="$(realpath ${target_path})"
  print -D -- "${real_path}"
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

  if [[ "${OSTYPE}" == darwin* ]] then
    cd "$(mktemp -d -t "${prefix}")"
  else
    cd "$(mktemp -d -t "${prefix}.XXXXXXXXXX")"
  fi
}

############ Print.

print-unicode() {
  local i=0 check_hex_to_dec code sep esc
  sep="${FS:- }"
  for ((i = 1; i <= $#; i++)) do
    code="$@[i]"
    code="${code#0x}"
    code="${code#\u}"
    code="${code#\U}"
    if (( #code <= 4)); then
      esc="\u"
    else
      esc="\U"
    fi
    echo -n "${esc}${code}"
    (( i != # )) && echo -n "${sep}"
  done
  echo
}

print-error() {
  local last_status=$?
  local msg="${fg_bold[red]}[  FAILED  ]"

  # In case we just want to print something in red and don't care about the last command.
  if (( last_status != 0 )); then
    msg+=" Exit code ${last_status}"
  fi

  if (( $# > 0 )); then
    msg+=":${reset_color} $@"
  else
    msg+="${reset_color}"
  fi

  print -u2 -- "${msg}"
  return $last_status
}

print-warning() {
  local msg="${fg_bold[yellow]}[  WARNING  ]"

  if (( $# > 0 )); then
    msg+=":${reset_color} $@"
  else
    msg+="${reset_color}"
  fi

  print -u2 -- "${msg}"
}

print-ok() {
  local msg="${fg_bold[green]}[  SUCCESS  ]"

  if (( $# > 0 )); then
    msg+=":${reset_color} $@"
  else
    msg+="${reset_color}"
  fi

  print -- "${msg}"
}

print-run-cmd() {
  local -a cmd=("$@")
  print-cmd --no-nl "${cmd[@]}"
  "${cmd[@]}"
}

# print cmd with bat highlight
function print-cmd() {
  local nl=""
  if [[ "${1}" == "--no-nl" ]]; then
    shift
  else
   nl="\n"
  fi
  local -a cmd=("$@")
  echo -n "$ "
  echo "${(q-@)cmd}${nl}" | bat -pp -lsh
}

# print cmd with bat highlight
function print-cmd-raw() {
  local nl=""
  if [[ "${1}" == "--no-nl" ]]; then
    shift
  else
   nl="\n"
  fi
  echo -n "$ "
  echo "${@}${nl}" | bat -pp -lsh
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

# Date
date-from-timestamp() {
  local timestamp="${1:?arg timestamp must be set}"
  # Note: expecting GNU `date`.
  print-run-cmd date -d "@${timestamp}"
}


## ssh
## -------------------------------------------------------------------------------------------------

function ssh-find-socket() {
  local socket_search_dir="${1:?arg 1 socket_search_dir must be set}"

  # (N): no return glob when no matches found
  local -a sockets=($~socket_search_dir/**/*(=N))
  if (( $#sockets == 0 )); then
    print-warning "No sockets found at ${socket_search_dir}"
    return 1
  fi
  local socket="${sockets[1]}"
  if (( $#sockets > 1 )); then
    print-warning "Multi sockets found at ${socket_search_dir}, choosing ${socket}"
  fi
  if [[ -z "$socket" ]]; then
    print-error "Socket found at ${socket_search_dir}, but path empty - should not happen"
    return 1
  fi
  REPLY="${socket}"
  return 0
}


function ssh-check-socket() {
  local verbose=false
  if [[ $1 == "-v" ]]; then
    verbose=true
    shift
  fi
  local host="${1:?arg 1 host must be set}"
  local socket_search_dir="${2:-~/.ssh}"

  ssh-find-socket "${socket_search_dir}" || return 1
  local socket="${REPLY}"

  # BSD stat
  # %HT %t %Sc %t %N
  # ===
  # %HT = file type long
  # %Sc = creation time
  # %N = file name
  #
  # time output -t, format strftime(3)
  # %F %r
  # ===
  # %F = %Y-%m-%d
  # %r = %I:%M:%S %p
  stat -f '%HT %t %Sc %t %N' -t '%F %r' "${socket}"

  if $verbose; then
    /usr/local/bin/ssh -O conninfo -S "${socket}" "${host}"
    /usr/local/bin/ssh -O channels -S "${socket}" "${host}"
  fi
  /usr/local/bin/ssh -O check -S "${socket}" "${host}"
}


function ssh-exit-socket() {
  local host="${1:?arg 1 host must be set}"
  local socket_search_dir="${2:-~/.ssh}"
  ssh-find-socket "${socket_search_dir}" || return 1
  local socket="${REPLY}"

  stat -f '%HT %t %Sc %t %N' -t '%F %r' "${socket}"
  /usr/local/bin/ssh -O check -S "${socket}" "${host}"
  print-run-cmd /usr/local/bin/ssh -O exit -S "${socket}" "${host}"
  /usr/local/bin/ssh -O check -S "${socket}" "${host}"
  if (( $? == 0 )); then
      print-error "Socket control still running for host=${host} socket=${socket}"
  else
      print-ok "Socket control stopped host=${host} socket=${socket}"
  fi
}


function ssh-interfaces() {
  local verbose=false verbose_flag=""
  if [[ $1 == "-v" ]]; then
    verbose=true
    verbose_flag="-v"
    shift
  fi

  lsof -c '/.*ssh.*/' -a -nP -iTCP -sTCP:ESTABLISHED +c 0
  local -a ips
  ips=(
    ${(f)"$(
      lsof -Fn -c '/.*ssh.*/' -a -nP -iTCP -sTCP:ESTABLISHED |
        grep '^n' |
        cut -d'>' -f2 |
        sed -E 's/:[0-9]+$//' |
        tr -d '[]' |
        sort |
        uniq
    )"}
  )
  echo

  if (( $#ips == 0 )); then
    print -u2 -- "No SSH connections found"
    return 1
  fi

  local interface inet_version ip_version ip_version_not
  echo "[Unique SSH targets]"

  for ip in "$ips[@]"; do
    local header="===================== ${ip} ====================="
    echo "\n${fg_bold[blue]}${header}${reset_color}"
    if [[ "$ip" == *":"* ]]; then
        # IPv6
        interface="$(route -n get -inet6 "${ip}" | awk '/interface:/ {print $2}')"
        ip_version="IPv6"
    else
        # IPv4
        interface="$(route -n get "${ip}" | awk '/interface:/ {print $2}')"
        ip_version="IPv4"
    fi

    if [[ -z "${interface}" ]]; then
      print-warning "Interface not found for ${ip}"
      continue
    fi

    # Some display helpers
    if [[ "${ip_version}" == "IPv6" ]]; then
      inet_version="inet6"
      # The inverse of ip version
      ip_version_not="IPv4"
    else
      inet_version="inet"
      ip_version_not="IPv6"
    fi

    echo "────────────────────────────────────┐"
    echo "route                               │"
    echo "────────────────────────────────────┘"
    route -n get -${inet_version} "${ip}" | head -n 5

    echo
    echo "────────────────────────────────────┐"
    echo "ifconfig                            │"
    echo "────────────────────────────────────┘"
    echo "ifconfig interface: ${interface}"
    echo "address family: ${inet_version}"
    ifconfig ${verbose_flag} -f inet6:cidr,inet:cidr "${interface}" "${inet_version}"


    if [[ "${OSTYPE}" == darwin* ]]; then
      echo
      echo "────────────────────────────────────┐"
      echo "macOS service info via networksetup │"
      echo "────────────────────────────────────┘"
      networksetup -listallhardwareports | grep --color=never -A1 -B1 "Device: ${interface}"

      if $verbose; then
        echo
        echo "────────────────────────────────────┐"
        echo "Verbose via system_profiler         │"
        echo "────────────────────────────────────┘"

        system_profiler SPNetworkDataType -json |
          jq \
            --arg interface "${interface}" \
            --arg delete "${ip_version_not}" \
            '.SPNetworkDataType[] | select(.interface == $interface) |  del(.[$delete])' |
          yq -P -o=toml
        # -Poy equivalent to
        # yq --prettyPrint -p=json -o=yaml
      fi
    fi

    # print "=" same number of times as $header chars
    print "${fg_bold[blue]}${(l:${#header}::=:)}${reset_color}"
  done
}


## -------------------------------------------------------------------------------------------------

# rsync
# usage: rsync-to host:path/dir
# usage: rsync-to host:path/dir --reverse
# usage: rsync-to host:path/dir --delete
function rsync-to() {
  local reverse="" delete=""

  local -a user_args=()
  while [[ $# -gt 0 ]]; do
    case $1 in
      -d | --delete) delete="yes"; shift ;;
      -r | --reverse) reverse="yes"; shift ;;
      *) user_args+=("$1"); shift ;;
    esac
  done

  local remote_sync_path="${user_args[1]:?arg 1 remote_path must be set}"

  local -a args=(
    --cvs-exclude --exclude-from=${HOME}/.config/git/ignore
    --archive
    --compress --partial
    --ignore-times --omit-dir-times --checksum
    --no-perms --executability
    --human-readable --verbose --progress
  )

  if [[ "${delete}" == "yes" ]]; then
    args+=(--delete-excluded --delete)
  fi

  if [[ -z "${reverse}" ]]; then
    # Local to remote
    echo "=== Syncing from local to remote ==="
    args+=(
      ./
      ${remote_sync_path}/
    )
  else
    # Remote to local
    echo "=== Reverse-syncing from remote to local ==="
    args+=(
      ${remote_sync_path}/
      ./
    )
  fi

  local -a dry=(rsync --dry-run --stats $args)
  print-cmd "${dry[@]}"
  ${dry[@]}

  echo

  local -a cmd=(rsync $args)
  print-cmd "${cmd[@]}"

  read -s -q "REPLY?Continue? (y/N) " || true
  REPLY="${REPLY:-n}"
  echo "$REPLY"
  if [[ "${REPLY}" == "y" ]] ;then
    echo
    ${cmd[@]}
  else
    echo "Exiting"
  fi
}
