# Custom aliases.
################## Directory hashes #################
hash -d o=/opt/local
hash -d oe=/opt/local/etc
hash -d ol=/opt/local/var/log
hash -d dev=$HOME/Development
hash -d icl="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
# hash -d p=$HOME/Projects
# hash -d b=$HOME/Projects/backup
# hash -d tu=$HOME/Documents/Tutorials

# Easy cd to project directories.
cdpath=($cdpath $HOME/Development)

################## Custom variables #################
# export PHP_SKEL_REPO=$GISTY_DIR/a5fc0f30080a086aabd9

# alias curl='noglob curl'

#################### Suffix #########################
# alias -s module=st

#################### Docker #########################
alias dcrr='docker-compose run --rm'

#################### DoSomething ####################
# alias v='vagrant';
# alias vs='vagrant ssh';
# alias vst='vagrant status';
# alias vsn='vagrant snapshot';
# alias vup='vagrant up';
# alias vh='vagrant halt';
# alias vrl='vagrant reload';
# alias vp='vagrant provision';
# alias m='mount';
# alias avd='ansible-vault decrypt --vault-password-file=.vault.txt'
# alias ave='ansible-vault encrypt --vault-password-file=.vault.txt'

# alias dk='nocorrect docker'
# alias dkr='docker run -it --rm'
# alias dkp='docker ps -a'
# alias dki='docker images'
# dkb() {
#   docker build -t $(basename $(pwd)) .
# }


# Vagrant shell
# vr() {
#   local arg
#   arg="${(qq)@}"
#   eval "vagrant ssh -c ${arg} -- -q"
# }
# alias vr='nocorrect noglob vr'
# alias v-log='vr sudo tail /var/log/salt/minion'

# Vagrant ds
# vd() {
#   local arg
#   arg="ds ${@}"
#   arg="${(qq)arg}"
#   eval "vagrant ssh -c ${arg} -- -q"
# }
# alias vd='nocorrect noglob vd'
# alias vdu='vd build; vd pull stage --db; notify-send Build ready'
# alias vdu='vd build --install; vd pull stage --db; notify-send Build ready'
# alias vdu='vd build --install; vd pull stage --db; notify-send Build ready'
# alias vdu='vd build --install; notify-send Build ready'
# alias vdu='vd build --no-db; notify-send Build ready'

# Vagrant drush
# alias dr='vr drush @ds.default -y --notify=10'
# alias drc='dr cc all'
# alias drup='dr updb; dr fra; dr cc all'
# alias drl='vr drush @ds.default ws --tail --full'

# alias v-rebuild='v destroy -f && vup && vr setup-www && vdu'
# alias v-rebuild='v destroy -f && vup && vdu'

# DoSomething develop-devel alter.
# alias gcd='git checkout dev'
# Ignore master.
# alias b='b | grep -v 0d04f84'
# Up
# alias gup='gcd; gpl; gpl upstream; gpl upstream dev; gf; gf upstream; b'

# Yarn tests
# alias t='yarn test'
# alias tl='yarn lint'
# alias tu='yarn test:unit'
# alias ti='yarn test:integration'
# alias tc='yarn coverage'
# alias tch='yarn coverage:report:html && open ./coverage/index.html'
# alias tf='yarn test:full'

# Other
# alias cr='noglob php --php-ini /opt/local/etc/php56/xdebug-disabled-php.ini ~/bin/composer';

# Bundler
# Pry
# alias bsh='bundle console'
# unalias pry
mqload() {
  local dkdir
  dkdir=~/Development/blink

  # Load and wait for docker.
  docker ps &> /dev/null || (echo -n "Loading Docker " && open -a Docker)
  until docker info &> /dev/null
  do
    echo -n "."
    sleep 1
  done
  echo " done"

  # Do stuff.
  docker-compose -f $dkdir/docker-compose.yml down
  docker-compose -f $dkdir/docker-compose.yml up -d
  # docker-compose -f $dkdir/docker-compose-development-host-only.yml down
  # docker-compose -f $dkdir/docker-compose-development-host-only.yml up -d
}

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
# adb logcat $(adb shell ps | grep com.suponix.budgetking | cut -c10-15 ) | coloredlogcat.py
# adb logcat com.suponix.budgetcare:I \*:S
# FragmentManager

####################### JYSK ########################
#alias resinctl='resinctl -DAPPENV=local'
#alias resinpid='jps -l | grep com.caucho.server.resin.Resin | cut -d" " -f1'

# Homestead
# function hs() {
#   DIRECTORY=$(pwd)
#   HOMESTEAD_DIRECTORY=~/Development/ds-homestead
#   HOME_RELATIVE_DIRECTORY=${DIRECTORY/$HOME/\~}
#   DEFAULT="ssh --command \"cd $HOME_RELATIVE_DIRECTORY; bash\""
#   (cd $HOMESTEAD_DIRECTORY; eval "vagrant ${*:-$DEFAULT}")
# }
