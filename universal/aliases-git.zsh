################## Universal aliases  #################
######################### Git  ########################

### Functions
b() {
  git branch --color=always --all -vv | grep -v origin/HEAD | cut -c3- | gsed -r 's#([^ ]*).* ([a-f0-9]{6,}) (\[([^]]*)\])?.*#\2\x1b[m \1\x1b[m \4#' | sort -t"/" -k3,1
}

### Productivity
alias g.='git add .'
alias gs='git status --short'
alias gf='git fetch -p'
alias gaa='git add --all .'
alias gpl='git pull'
alias gpf='git push --force-with-lease'
alias grb='git rebase'
alias gbd='git branch -d'

alias gu='git restore --staged'
alias gu.='git restore --staged .'

### Log
# Just git log.
alias gl='git log'
alias glln='git --no-pager log'

# Git log from origins to current.
# alias gll='git log @{u}..'
#alias gllo='git log origin..'
#alias gllh='git log heroku/master..'

alias 'g-'='git log --pretty=graph --branches --remotes --tags --graph --date=short'

### Per word diffs
alias gdw='git diff -U0 --abbrev --color-words'

# Cached
alias gdwc='gdw --cached'

# Show.
alias gsw='git show -U1 --color-words --abbrev-commit --pretty=medium'

### Tools
# Interactive clean.
alias gclo='git clean -id'

### Info
# Last commit
alias glc='git rev-parse --short'

### Git Flow
# alias f='git flow'
# alias ff='git flow feature'
# alias fs='git flow feature start'
# alias fr='git flow release'

# Svn
# # Return the current svn branch name, define a global alias calling it.
# # Example: `grbi trunk` = `grbi $gs`; `gll trunk..` = `gll $gss`
# alias gsb='echo ${$(g config --get svn-remote.svn.fetch | cut -d: -f2)#refs/remotes/}'
# # alias -g '$gs'='$(gsb)'
# # alias -g '$gss'='$(gsb)".."'

# # gll, grbi from current svn remote to HEAD. Completion is not needed.
# alias glls='git log $(gsb)..'
# alias grbis='git rebase -i $(gsb)'
