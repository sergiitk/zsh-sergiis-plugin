################## Universal aliases  #################
######################### Git  ########################

### Functions
### Productivity
alias g.='git add .'
alias gpl='git pull'

# Branches
alias b='git branch -vv --sort=refname'
bb() {
  git branch --color=always --all -vv | grep -v origin/HEAD | cut -c3- | gsed -r 's#([^ ]*).* ([a-f0-9]{6,}) (\[([^]]*)\])?.*#\2\x1b[m \1\x1b[m \4#' | sort -t"/" -k3,1
}

# give gcl to gcloud
alias gcln='git clone --recurse-submodules'

# Restore
alias gr='git restore'
alias gr.='git restore .'
alias grs='git restore --staged'
alias grs.='git restore --staged .'
# alias grs='git restore --staged'
# alias grs.='git restore --staged .'

### Log
# Just git log.
alias gl='git log'
# alias glln='git --no-pager log'

# Git log from origins to current.
# alias gll='git log @{u}..'
#alias gllo='git log origin..'
#alias gllh='git log heroku/master..'

alias 'g-'='git log --pretty=graph --branches --remotes --tags --graph --date=short'

glb() {
  gl $(git merge-base $(git_main_branch) $1)..$1
}
compdef _git glb=git-branch

### Per word diffs
alias gdww='git diff -U0 --abbrev --color-words'
# alias gds='git diff -U0 --abbrev --color-words'

# Staged
# alias gdwc='gdw --cached'
alias gdsw='git diff --staged --word-diff'
alias gdsww='git diff --staged -U0 --abbrev --color-words'

# Show.
alias gsw='git show --format=fuller'
alias gsww='git show -U1 --color-words --abbrev-commit --pretty=fuller'
alias gswf='git show --name-only'

### Tools
# Interactive clean.
# alias gclo='git clean -id'

### Info
# Last commit
alias glc='git rev-parse --short HEAD'

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
