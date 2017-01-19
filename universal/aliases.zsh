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
# SSH
alias s='ssh'
# Less
# alias ß='less'
# alias -g ßß='| less'
# Turn off word wrapping.
# alias -g ßß='| less -S'
alias -g G='| grep'
# Follow file with tailf.
alias tailf='tail -f'
alias tf='tail -f'

# Exif
alias 'exif?'="exiftool-5.22 -a -u -g1"


### Miscellaneous apps.
alias r=rails
alias ru='rvm use'
alias rug='rvm use @global'
# Or gemsets.
alias ge='rvm gemset list'
# alias h=heroku

### Print
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
alias od1='od -ctd1'


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

