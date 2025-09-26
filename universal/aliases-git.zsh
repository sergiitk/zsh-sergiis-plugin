################## Universal aliases  #################
######################### Git  ########################

### Functions

# omz plugin info git
# undo omz aliases https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git

# gitk --all --branches &!
# install tcl?
# dies with /usr/bin/wish: line 2: 24818 Killed: 9
(( ${+aliases[gk]} )) && unalias gk

### Productivity
alias g.='git add .'
alias gpl='git pull'
alias gnp='git --no-pager'

# Switch.
# Also overrides 'gs' Ghostscript
# alias gs='git switch'

# GitHub
gs() {
  local handle branch default_handle="${USER}"
  local -a args=("$@")

  # easy copy-paste from github
  if [[ "${1}" == *:* ]]; then
    handle="$(echo "${1}" | cut -d: -f1)"
    branch="$(echo "${1}" | cut -d: -f2)"
    if [[ "${handle}" != "${default_handle}" ]]; then
      echo "TODO - what to do with other remotes?"
    fi
    shift
    args=("${branch}" "$@")
  fi

  git switch "${args[@]}"
}

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
# shellcheck disable=SC2154
alias -g '$gbb'='$(gbb)'

# Rebase
alias grbb='git rebase --interactive $(gbb)'

### Log
alias gl='git log'
alias 'g-'='git log --pretty=graph --branches --remotes --tags --graph --date=short'
# human log with no pager
alias glh='git --no-pager log --reverse --pretty=cool --date=human'

# Log commits in a given branch.
glb() {
  local branch="${1:-HEAD}"
  local -a args=()
  if [[ "${branch}" == "--" ]]; then
    branch="HEAD"
    args=("$@")
  elif [[ "${1:-}" == "--" ]]; then
    shift
    args=("$@")
  fi
  local fork_point
  fork_point="$(git merge-base "$(git_main_branch)" "${branch}")"
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
# Restore from the merge base.
alias grsb='git restore -s $(gbb) --'



# Reset.
# omz plugin sets it to just 'git reset'
alias grh='git reset --hard'
# to origin
alias grho='git reset --hard origin/$(git_current_branch)'
# to upstream
alias grhu='git reset --hard upstream/$(git_current_branch)'
# to the tracking branch
# https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-branchnameupstreamegmasterupstreamu
alias grht='git reset --hard "@{u}"'

# Diff the current branch
alias gdb='git diff $(gbb)...HEAD'

### Per word diffs
alias gdww='git diff -U0 --abbrev --color-words'
# alias gds='git diff -U0 --abbrev --color-words'

### Staged diffs
alias gdsw='git diff --staged --word-diff'
alias gdsww='git diff --staged -U0 --abbrev --color-words'

# patch formats: use -U<n> / --unified=n to set the number of context lines to n.
alias gds-patch='git --no-pager diff --staged --no-color --patch'

# patch format
# alias gdd='git --no-pager diff --patch --unified=1 --no-color --staged'

# Show.
alias gsw='git show --format=fuller'
alias gsww='git show -U1 --color-words --abbrev-commit --pretty=fuller'
alias gswf='git --no-pager show --name-only'

# Stash.
alias gstl='git --no-pager stash list --format=stash'
alias gsts-patch='git --no-pager stash show --no-color --patch'

## Remotes and refs

# Refspec format:
# refspec: https://git-scm.com/docs/git-fetch
# git check-ref-format --refspec-pattern 'upstream/v1.*?' && echo pass
# git check-ref-format --normalize --refspec-pattern 'upstream/v1.*'

# List origin branches with date in columns
# shows branches with origin/
alias gbrl="noglob git branch --remotes --format '%(refname:lstrip=2)' --list"
# shows branches without origin/
# can be used for bulk branch delete
# gbrl3 origin/create-pull-request/patch-* | xargs -p git push origin --delete
alias gbrl3="noglob git branch --remotes --format '%(refname:lstrip=3)' --list"
alias gbrld="noglob git branch --remotes --format '%(committerdate:short)%09%(refname:lstrip=2)' --sort=committerdate --list"

# reversed columns
# git branch --remotes --list 'origin/*' --format '%(align:width=70)%(refname:lstrip=3)%(end)%(committerdate:short)' --sort=committerdate

# Delete origin branches starting with prefix
# git branch --remotes --list 'origin/v1*' --format '%(refname:lstrip=3)' | xargs echo git push origin --delete
# gpod = git push origin --delete

# delete remote branch
gbdr() {
  local branch="${1:?branch not set}"
  local -a remotes branch_segments
  remotes=( $(git remote) )
  branch_segments=(${(@s:/:)branch})
  segment_candidate=$branch_segments[1]

  remote="origin"
  if (( $remotes[(Ie)$segment_candidate] )); then
    remote="${segment_candidate}"
    branch="${(j:/:)branch_segments:1}"
  fi

  cmd=(git push "${remote}" --delete ${branch})
  print-cmd "${cmd[@]}"
  ${cmd[@]}
}

# Reading and changing remote fetch.
# st .git/config
#
# git config get --local --all remote.upstream.fetch
# +refs/heads/*:refs/remotes/upstream/*
# ^refs/heads/dependabot/*
#
# Override remote.upstream.fetch
# git config set --local --replace-all remote.upstream.fetch '+refs/heads/master:refs/remotes/upstream/master'
#
# Ignore refs by appending
# git config set --local --append remote.upstream.fetch '^refs/heads/dependabot/*'

# List remote heads
# git ls-remote --heads upstream

# Show remotes and tracking
# git remote show upstream

# Use local index only:
# git remote show upstream -n

# Verbose flag isn't really needed, just to be consistent with grv.
alias grvs='git remote --verbose show -n'
alias grvsq='git remote --verbose show'

# Reflog
# l .git/logs/refs/remotes/upstream/
# l .git/logs/refs/heads
# git reflog list
#
## Cleaning refs (unsorted)
# git for-each-ref 'refs/remotes/upstream/create-pull-request/**' --format="%(refname)" | xargs -t -I% echo git update-ref -d %
# git remote --verbose prune upstream
# git fetch --verbose --prune upstream
# git gc --prune=now
# bat .git/packed-refs
# git pack-refs --verbose --prune

### Tools
# Interactive clean.
# alias gclo='git clean -id'
# Clean gone branches
alias gone='git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | grep -Ev "\$^"'
alias goneD='gone | xargs -r -n1 -p git branch -D'
# alias gone='git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | xargs -p git branch -D'
