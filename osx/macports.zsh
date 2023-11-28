# Macports customizations

# Load macports autocomplete
fpath=(/opt/local/share/zsh/site-functions $fpath)

# BSD version of find is just pathetic.
alias find=gfind
compdef gfind=find
alias xargs=gxargs
compdef gxargs=xargs
alias realpath='greadlink -f'

# BSD version doesn't assign default group when it's omitted (`chown user:`).
alias chown=gchown
compdef gchown=chown
# Also reassign chmod for consistency.
alias chmod=gchmod
compdef gchmod=chmod
# Stupid BSD head just can't accept negative nubers count, so it's not possible
# to skip just last line.
alias head=ghead
# Again, BSD tr is incompatible.
# alias tr=gtr


# Uninstall leaves
alias pul='sudo port uninstall leaves'
alias pu='sudo port uninstall'

