# Custom aliases.
################## Directory hashes #################
# Homedir Library
hash -d libas="$HOME/Library/Application Support/"
# hash -d lib_icl="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"

# Development
# alias dev='cd ~/Development'
hash -d d="${HOME}/Development"
hash -d dev="${HOME}/Development"
hash -d play="${HOME}/Development/playground"
hash -d p="${HOME}/Development/projects"

# user home shortcuts
hash -d b="${HOME}/.bin"
hash -d r="${HOME}/Downloads/__remove"

# MacPorts
hash -d o=/opt/local
hash -d oe=/opt/local/etc
hash -d ol=/opt/local/var/log

# Easy cd to project directories.
cdpath=($cdpath $HOME/Development)

#################### noglob #########################
alias bazel='noglob bazel'

################## highlighting #####################
# https://github.com/sharkdp/bat
# Syntax shortcurts, useful as colorized less
alias yml='bat -l yaml -pp --color=always'
alias jsn='bat -l json -pp --color=always'
alias ini='bat -l ini -pp --color=always'
alias hlp='bat -l help -pp --color=always'
hj() {
  local cmd
  cmd=$(echo "$@" | sed "s/ --help//")
  zsh -ic "$cmd --help" |& bat -l help -pp --color=always
}

# Pager versions
alias ymll='bat -l yaml -p'
alias jsnl='bat -l json -p'
alias inil='bat -l ini -p'
alias hlpl='bat -l help -p'

alias dl='delta'

#################### docker #########################
alias dcup='docker-compose up -d'
alias dk='nocorrect docker'
alias dkp='docker ps -a'
alias dkpe='docker ps -a -q --filter "status=exited"'
alias dki='docker images'
# alias dkrm='docker rm --force'
alias dkr='docker run -it --rm'
alias dcrr='nocorrect docker-compose run --rm'
alias dcre='docker-compose down; docker-compose up -d'

#################### kubectl #########################
# plugin: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl
alias kd='kubectl describe'
alias kg='kubectl get'
alias kc='kubectl config'
alias kcv='kubectl config view --minify | yml'
function kgy() {
  local name="${1:?missing the api_resource argument}"
  kubectl get "$@" -o yaml | bat -l yaml --paging=never --style="grid,header" --file-name="${name}"
}

#################### gcloud ##########################
# plugin: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gcloud
alias gcl='gcloud'

alias gcla='gcloud config configurations activate'
alias gcll="gcloud config configurations list"
# bat -l yaml --paging=never --style="grid,header" --file-name="${name}"
# alias gcl-cfg="gcloud config list 2>&1 | ini"
function gcl-cfg() {
  local file_name="${P9K_GCLOUD_PROJECT_ID:-gcloud_config_list}.ini"
  gcloud config list 2>/dev/null | bat --paging=never --style="grid,header" --file-name="${file_name}"
}

alias gclcc='gcloud container clusters'
alias gclccl='gcloud container clusters list'
alias gclccr='gcloud container clusters get-credentials'

###################### Python #######################
alias i='ipython'
alias pv='source ./venv/bin/activate'

###################### Nodejs #######################

# Yarn tests
# alias y='yarn'
# alias yl='yarn lint'
# alias yt='yarn test'
# alias ytf='yarn test:full'
# alias t='yarn test'
# alias tl='yarn lint'
# alias tu='yarn test:unit'
# alias ti='yarn test:integration'
# alias tc='yarn coverage'
# alias tch='yarn coverage:report:html && open ./coverage/index.html'
# alias tf='yarn test:full'

###################### Android ######################
# alias lcdb='lc l AndroidRuntime:e budgetking.db BudgetApplication_ TableUtils BaseMappedStatement StatementExecutor MappedCreate'
# alias a=adb
# alias a-='adb devices -l'
# alias a-wifi='adb tcpip 5555 && adb connect android'
# alias a-unpack='dd if=data.ab bs=1 skip=24 | openssl zlib -d | tar xvf -'

# alias adbl='adb logcat \*:W | coloredlogcat.py'
# alias adble='adb logcat \*:E | coloredlogcat.py'
# alias adbll='adb logcat -s "logmarker" | coloredlogcat.py'
# adb logcat ActiveAndroid:V SQLiteStatements:V \*:S | coloredlogcat.py
# adb logcat | grep --line-buffered $(adb shell ps | grep com.suponix.budgetking | cut -c10-15 ) | coloredlogcat.py
# adb logcat $(adb shell ps | grep com.example.budgetk | cut -c10-15 ) | coloredlogcat.py
# adb logcat com.example.budgetc:I \*:S
# FragmentManager

####################### resinctl ########################
#alias resinctl='resinctl -DAPPENV=local'
#alias resinpid='jps -l | grep com.caucho.server.resin.Resin | cut -d" " -f1'
