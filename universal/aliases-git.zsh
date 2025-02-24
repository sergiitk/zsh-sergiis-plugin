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

### Info
# Last commit
alias grpl='git rev-parse --short HEAD'

# Rev-parse short
# Nice Usages:
# grp "python-black@{1 day ago}"
# grp "@{1 month ago}"
# grp @{1} - one commit ago
# grp @{u} - upstream
alias grp='git rev-parse --short'

# Branch fork
alias gbb='git merge-base $(git_main_branch) HEAD'
alias -g '$gbb'='$(gbb)'

# Rebase
alias grbb='git rebase --interactive $(gbb)'

### Log
alias gl='git log'
alias 'g-'='git log --pretty=graph --branches --remotes --tags --graph --date=short'

# Log commits in a given branch.
glb() {
  local branch="${1:-HEAD}"
  local -a args=()
  if [[ "$branch" == "--" ]]; then
    branch="HEAD"
    args=("$@")
  elif [[ "${1:-} == "--"" ]]; then
    shift
    args=("$@")
  fi
  local fork_point=$(git merge-base $(git_main_branch) ${branch})
  git --no-pager log --reverse --pretty=graph --date=human "${fork_point}..${branch}" "${args[@]}"
}
compdef _git glb=git-branch

# Restore
alias gr='git restore'
alias gr.='git restore .'
alias grs='git restore --staged'
alias grs.='git restore --staged .'
alias gr!='git restore --staged --worktree --'
alias grsm='git restore -s $(git_main_branch) --'
# Restore from merge base. Should be equivalent to `git restore -s master...`
alias grsb='git restore -s $(gbb) --'


# Diff the current branch
alias gdb='git diff $(gbb)...HEAD'

### Per word diffs
alias gdww='git diff -U0 --abbrev --color-words'
# alias gds='git diff -U0 --abbrev --color-words'

### Staged diffs
alias gdsw='git diff --staged --word-diff'
alias gdsww='git diff --staged -U0 --abbrev --color-words'
# patch formats: use -U<n> / --unified=n to set the number of context lines to n.
alias gdsp='git diff --staged --no-color --patch'

# patch format
# alias gdd='git --no-pager diff --patch --unified=1 --no-color --staged'

# Show.
alias gsw='git show --format=fuller'
alias gsww='git show -U1 --color-words --abbrev-commit --pretty=fuller'
alias gswf='git show --name-only'

# Stash.
alias gstl='git --no-pager stash list --date=human'

# Switch.
# Also overrides 'gs' Ghostscript
alias gs='git switch'

### Tools
# Interactive clean.
# alias gclo='git clean -id'
# Clean gone branches
alias gone='git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | grep -Ev "\$^"'
alias goneD='gone | xargs -r -n1 -p git branch -D'
# alias gone='git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | xargs -p git branch -D'
