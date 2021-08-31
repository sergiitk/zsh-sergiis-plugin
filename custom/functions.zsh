################## Custom Functions  ##################

##################### tmux ##########################
alias t='tmux'
alias tc='tmux -CC'
alias ta='tmux -CC attach -t'
alias tl='tmux list-sessions'
tn() {
  if [[ $1 == '-h' ]]; then
    pe "usage: [session name] [window name]"
    return 1
  fi
  tmux -CC new -A -s ${1:=tmux} -n ${2:=work}
}

tt() {
  if [[ -z $1 ]]; then
    pe "usage: <session name> [window name]"
    return 1
  fi
  tmux rename-session $1
  if [[ ! -z $2 ]]; then
    tmux rename-window $2
  fi
}

tw() {
  if [[ -z $1 ]]; then
    pe "usage: <window name>"
    return 1
  fi
  tmux rename-window $1
}

idea-set-file-colors() {
  if [[ -z $2 ]]; then
    pe "usage: <non-project-color> <tests-color>"
    return 1
  fi
  xmllint --shell "${HOME}/Library/Application Support/JetBrains/IdeaIC2021.1/options/other.xml" &> /dev/null << EOF
  cd /application/component[@name='PropertiesComponent']/property[@name='file.colors.enable.non.project']/@value
  set $1
  cd /application/component[@name='PropertiesComponent']/property[@name='file.colors.enable.tests']/@value
  set $2
  save
EOF
  if (( $? == 0 )); then
      echo "OK"
  else
      echo "Fail"
  fi
}

idea-dark() {
  idea-set-file-colors 292b34 434d48
}

idea-light() {
  idea-set-file-colors eff1f6 f1f6ef
}

ls-except() {
  if [[ -z $2 ]]; then
    pe "usage: <path/to/list> <dir-name-to-exclude>"
    return 1
  fi
  print -l "$1"*~"$1$2"(/)
}

##################### powerlevel10k ##########################

# https://github.com/romkatv/powerlevel10k#why-some-prompt-segments-appear-and-disappear-as-im-typing
function ps-kube() {
  if (( ${+POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND} )); then
    unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
    POWERLEVEL9K_VCS_SHOW_ON_COMMAND='git'
    POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  else
    POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile'
    unset POWERLEVEL9K_VCS_SHOW_ON_COMMAND
    POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

function ps-gcloud() {
  if (( ${+POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND} )); then
    unset POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND
    POWERLEVEL9K_VCS_SHOW_ON_COMMAND='git'
    POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  else
    POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs'
    unset POWERLEVEL9K_VCS_SHOW_ON_COMMAND
    POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

# zle -N kube-toggle
# bindkey '^]' kube-toggle  # ctrl-] to toggle kubecontext in powerlevel10k prompt

##################### Dotfiles ##########################

local dtfiles="gitconfig gitignore_global gemrc profile ssh/config ssh/known_hosts vimrc wgetrc zshrc zlogin tmux.conf p10k.zsh config/bat/config"
function dt() {
  if [[ -z $1 ]]; then
    print $dtfiles
    return 1
  fi
  subl ~/.$1
}
compctl -x 'p[1]' -k "($dtfiles)" -- dt
alias dt='nocorrect dt'

# ############ Android.
# # Adb logcat
# lc() {
#   if [[ $1 == "--help" ]]; then
#     pe "usage: $0 [global-loglevel: v, d, i, w, e, f] [options] [#grep]"
#     return 1
#   fi
#   local opts loglevels tag
#   loglevels=(v d i w e f)
#   opts=($@)
#   tag=""

#   if [[ -n $1 ]]; then
#     # loglevel
#     if [[ ${loglevels[(r)${opts[1]}]} == ${opts[1]} ]]; then
#       opts[1]="*:${opts[1]}"
#     else
#       opts=("-s" ${opts})
#     fi
#     # grep tag
#     if [[ ${opts[-1][1]} == "#" ]]; then
#       tag=${opts[-1][2,-1]}
#       opts[-1]=""
#     fi
#   fi

#   if [[ ${tag} == "" ]]; then
#     # echo ${opts}
#     adb logcat ${opts} | coloredlogcat.py
#   else
#     if [[ "${opts}" == "-s " ]]; then
#       opts=""
#     fi
#     # echo ${opts}
#     # echo ${tag}
#     adb logcat ${opts} | grep --line-buffered ${tag} | coloredlogcat.py
#   fi
# }
# alias lc="noglob lc"
