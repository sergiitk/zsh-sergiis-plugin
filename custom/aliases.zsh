# Custom aliases.
################## Directory hashes #################
# Homedir Library
hash -d libas="$HOME/Library/Application Support/"
# hash -d lib_icl="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"

# Development
alias dev='cd ~/Development'
hash -d dev=$HOME/Development
hash -d play=$HOME/Development/playground
hash -d p=$HOME/Development/projects

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
alias yml='bat -l yaml --plain --paging=never --color=always'
alias jsn='bat -l json --plain --paging=never --color=always'
alias ini='bat -l ini --plain --paging=never --color=always'
# Pager versions
# alias yml-l='bat -l yaml -p'
# alias jsn-l='bat -l json -p'
# alias ini-l='bat -l ini -p'

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
alias kc='kubectl config'
alias kcv='kubectl config view --minify | yml'

#################### gcloud ##########################
# plugin: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gcloud
alias gcl='gcloud'
alias gclcfg="gcloud config list 2>&1 | ini"
alias gclcfgl="gcloud config configurations list"
alias gclcc='gcloud container clusters'
alias gclccl='gcloud container clusters'
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
