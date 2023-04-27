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
# Replace oh-my-zsh's alias l='ls -la': append file type indicators.
alias l='ls -laF'
# Cat
alias c='cat'
alias cat='bat --paging=never'
# alias cat='bat'
# SSH
alias s='ssh'
# Less
alias le='less'
# alias ß='less'
# alias -g ßß='| less'
# Turn off word wrapping.
# alias -g ßß='| less -S'
# alias -g G='| grep'
# Follow file with tailf.
alias tailf='tail -f'
alias tf='tail -f'
# cpuinfo
# envvars
# fstab
# hs
# log
# properties
# toml
# vy

# See man zshbuiltins
# history: Same as fc -l.
alias h='history'
alias hs='history -rn | grep -Ei'
# Search full words.
hsw() {
  history -rn | grep -P "(?<!(\w|-))$argv(?!\w)"
}
# Search from the beginning
hss() {
  history -rn | grep -Ei "^${argv}"
}

alias hsd='history -rni | grep -Ei'
alias hl='history -r -i | bat --style="header,grid" -l vy'

# Exif
alias 'exif?'="exiftool -a -u -g1"

### Printing
alias e='echo'
# Print the arguments separated by newlines instead of spaces.
alias p='print -l'
# compdef p=print
# Print no new line
alias pn='print -n'
# Print the arguments separated by NULL character instead of spaces.
alias pnl='print -N'
# compdef pn=print
# Print to stderr.
alias pe='print -u2'
# compdef pe=print

### Text
# Easy decimal dump.
alias od1='od -tc -td1'
alias ud1='iconv -f UTF-8 -t UCS-2 | od -tc -tx1'
alias udx='iconv -f UTF-8 -t UCS-2 | xxd'

### Paths
# Resolve what is the command.
alias '?'='nocorrect whence -asvf'
# alias whf='whence -asvf'

# compdef wh=whence

### Utilites.
# Generate password to clipboard.
alias pbgen='pwgen --symbol 15 1 | tr -d "\n" > >(pbcopy) > >(cat); echo'
# Show open ports.
alias openports='_ lsof -Pn -i4TCP -sTCP:LISTEN | sort -t":" -k2n | grep -P "(?<=:)[0-9]+ "'
# Serve current folder at :8000 with python HTTP Server.
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
