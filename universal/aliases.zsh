################## Universal aliases  #################
####################### General  ######################
######## Expand arguments as aliases.
# zshmisc / Aliasing: If the text ends with a space, the next word in
# the shell input is treated as though it were in command position
# for purposes of alias expansion.
### Important! Pass aliases through sudo.
alias sudo='sudo '

######## ZSH helpers
### Vital overrides
# presume we're using the gnu version
# alias  l='ls -lA --classify --group-directories-first --sort=version -h'
alias ll='ls -l --classify --group-directories-first --sort=version'
alias l='ll -Ah'
alias la='ll -a'

# -F: as per ls -F, append
#   `/' for directories
#   `=' for socket files
#   `*' for executable files
#   `|' for FIFO's
# -x: Stay on the current file-system only.
alias tree='tree -F -x'

## mv (using non-gnu)
# Safe mv: do not overwrite an existing file by default.
alias mv='mv -v -n'
# Interactive move.
alias m='mv -v -i'

### Productivity

# touch
alias t='touch'
# see functions.zsh
alias tx="touchx"

# realpath
alias rp='realpath'

# symbolic, verbose, no-dereference
# lk /from/realpath /to/symlinkpath
# lk $(rp file) symlink
alias lk='ln -svn'

# Cat
alias c='bat -pp' # plain, no pager
# alias cat='bat --paging=never'
# alias cat='bat'

# Date
alias dt='date "+%F"'
alias dtt='date "+%Y%m%d"'

# SSH
alias s='ssh'

# less
alias le='less'
# alias ß='less'
# alias -g ¬='| less'
# Turn off word wrapping.
# alias -g ßß='| less -S'
# alias -g G='| grep'

# tail
alias tailf='tail -f'
alias tf='tail -f'

# history
# See man zshbuiltins
# history: Same as fc -l.
alias h='history'
# Highlighted, reversed, with timestamp and dates.
# alt highlight options: cpuinfo, envvars, fstab, hs, log, properties, toml, vy
alias hl='history -r -iD 1 | bat --style="header,grid" -l vy'
alias hlr='history -iD 1 | bat --style="header,grid" -l vy'
# History search, without line number.
alias hs='history -rn 1 | grep -Ei'
# Show last N lines, no line number. Grep the second arg if set.
hlast() {
  emulate -L zsh
  setopt extended_glob
  local num="${1}"
  if [[ "${num}" != [[:digit:]]## ]]; then
    print -u2 -- "Wrong number of lines: ${num}"
    return 1
  fi
  local result
  result=$(history -rn "-${num}" | grep -Ev '^(h |history |hlast )' | tac)
  if [[ -n "${2}" ]]; then
    echo "${result}" | grep "${2}"
  else
    echo "${result}"
  fi
}

# Search with date and duration.
alias hsd='history -rn -iD 1 | grep -Ei'
# Search full words.
hsw() {
  history -rn 1 | grep -P "(?<!(\w|-))$argv(?!\w)"
}
# Search from the beginning
hss() {
  history -rn 1 | grep -Ei "^${argv}"
}

# Exif
alias 'exif?'="exiftool -a -u -g1"

### Printing
alias e='echo'
# Print the arguments separated by newlines instead of spaces.
alias p='print -l --'
# Print no new line
alias pn='print -n --'
# Print the arguments separated by NULL character instead of spaces.
alias pnl='print -N --'
# Print to stderr.
alias pe='print -u2 --'

### Text
# Easy decimal dump.
alias od1='od -tc -tu1 -tx1'
# UTF-8 to unicode codepoints
# first line unsigned dec, second line hex
alias ud1='iconv -f UTF-8 -t UCS-2LE | od -tu2 -tx2'
# should this be UCS-2LE too?
# can be used with `p '\uCODE'`?
alias udx='iconv -f UTF-8 -t UCS-2 | hexdump'

### Paths
# Resolve what is the command.
alias '?'='nocorrect whence -asvf'
# alias whf='whence -asvf'

# processes
alias pkill="noglob pkill"
alias pgrep="noglob pgrep"
if [[ "${OSTYPE}" == darwin* ]]; then
  alias pkl="noglob pkill -l -if"
  alias pklu='noglob pkill -U "${USER}" -l -if'
else
  alias pkl="noglob pkill -e -if"
fi
alias pgr="noglob pgrep -al -if"
alias pgru='noglob pgrep -U "${USER}" -al -if'

# kill by port, linux only
# fuser -k -n tcp 4000

# compdef wh=whence

### Utilites.
# python
alias py='python3'

# Generate password to clipboard.
alias pbgen='pwgen --symbol 15 1 | tr -d "\n" > >(pbcopy) > >(cat); echo'

# Show open ports.
alias openports='_ lsof -Pn -i4TCP -sTCP:LISTEN | sort -t":" -k2n | grep -P "(?<=:)[0-9]+ "'
alias showport='lsof -Pn -i'

# Serve current folder at :8000 with python HTTP Server.
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"

### Noglob commands
alias tldr='noglob tldr'
alias man='noglob man'

# plutil -convert json -r -o - net.shinyfrog.bear.plist | bat -pp -l json
# plutil -extract NSUserKeyEquivalents json -r -o - net.shinyfrog.bear.plist | bat -pp -l json

# rsync
# usage: rsync-to /target/dir
# usage: rsync-to /target/dir --dry-run
# usage: rsync-to /target/dir -n
alias rsync-to="rsync --archive --relative \
  --compress --partial \
  --delete-excluded --delete \
  --ignore-times --omit-dir-times --checksum \
  --no-perms --executability \
  --human-readable --itemize-changes --verbose \
  --cvs-exclude --exclude-from=.gitignore --exclude-from='${HOME}/.config/git/ignore'\
  ."
