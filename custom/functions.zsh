################## Custom Functions  ##################


# # Send grown message.
# growl() {
#   print -n '\e]9;'${@}'\007'
# }

# ############ Wordpress
# # Enable completion for WordPress CLI utility.
# alias wp-cmp='autoload bashcompinit; bashcompinit; source ~p/contrib/php/wp-cli/vendor/wp-cli/wp-cli/utils/wp-completion.bash'

# # Install/commit.
# wpi() {
#   setopt localoptions errreturn
#   local name version
#   if [[ -z $1 ]]; then
#     pe "usage: $0 <plugin>"
#     return 1
#   fi
#   if [[ -n $(gdc --name-only) ]]; then
#     pe "Git stage is not empty, please clean it up first."
#     return 1
#   fi
#   wp plugin install --activate $1
#   ga wp-content/plugins/$1
#   name=$(wp plugin get $1 --field=name)
#   version=$(wp plugin get $1 --field=version)
#   gcmsg "Install plugin $name $version." -e
# }
#
# compctl -W ~ -g '.*(/)' - -f s.
# zstyle ':completion::complete:cd:*' tag-order 'named-directories:-mine:extra\ directories named-directories:-normal:named\ directories *'
# zstyle ':completion::complete:cd:*:named-directories-mine' fake-always mydir1 mydir2
# zstyle ':completion::complete:cd:*:named-directories-mine' ignored-patterns '*'

# zstyle ':completion::complete:hello:*' tag-order 'named-directories:-mine:extra\ directories named-directories:-normal:named\ directories *'
# zstyle ':completion:*:*:hello:*' fake-always '~'
# zstyle ':completion:*:*:hello:*' named-directories '~'
# zstyle ':completion:*:*:hello:*' file-patterns '.*(D)' '*:all-files'
# zstyle ':completion:*:*:hello:*' file-patterns '$HOME/.*(D)' '*:all-files'
# zstyle ':completion:*:*:hello:*:files' keep-prefix true
# zstyle ':completion:*:*:hello:*:files' keep-prefix true
# zstyle ':completion:*:*:hello:*:files' accept-exact-dirs
# zstyle ':completion:*:*:hello:*'
# zstyle ':completion:*:*:hello:*' file-patterns '.*(D)'
# compctl -W ~ -g '.*(D)' hello
# compctl -W ~ -g '.*(D)' hello

local dtfiles="gitconfig gitignore_global gemrc profile ssh/config ssh/known_hosts  vimrc wgetrc zshrc zlogin"
function dt() {
  if [[ -z $1 ]]; then
    print $dtfiles
    return 1
  fi
  subl ~/.$1
}
compctl -x 'p[1]' -k "($dtfiles)" -- dt
alias dt='nocorrect dt'

############ Gists.
# Print nginx config from repo.
NGINX_REPO=$GISTY_DIR/017c534973db372fbd82
nginxconf() {
  local etc dir file
  etc=/opt/local/etc/nginx
  if [[ -z $1 ]]; then
    print -l $NGINX_REPO/*(.:t)
    return 1
  fi
  if [[ -z $2 ]]; then
    print .
    print -l $etc/^(*default|koi*|win*)(/oL:t)
    return 1
  fi
  dir=$2
  if [[ $dir = "." ]]; then
    dir=""
  else
    dir="${dir}/"
  fi
  file=$etc/$dir$1
  if [[ -a $file ]]; then
    _ cp -v $file $etc/${dir}backup.$1.prev >&2
  fi
  pe "Compiling $file\n"
  grep -Pv "^( *#.*|$)" $NGINX_REPO/$1 | _ tee $file
}

############ DB helpers
# Backup databases.
MYSQL_BACKUP_PATH=~/Projects/backup/db
mysqlbackup() {
  setopt localoptions
  local backup_path backup_file repo
  if [[ -z $1 ]]; then
    repo=$(basename $(g rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
    if [[ -z $repo ]]; then
      p $MYSQL_BACKUP_PATH/*(/:t)
      return 1
    fi
  else
    repo=$1
  fi

  backup_path=$MYSQL_BACKUP_PATH/$repo

  print "\e[38;5;071mBacking up \e[48;5;235m $repo ${bg[default]} database."$reset_color;
  backup_file=$(date '+%Y%m%d-%H%M').sql
  mysqldump --single-transaction $repo > $TMPDIR/$backup_file
  if [[ $? == 0 ]]; then
    if [[ ! -d $backup_path ]]; then
      echo "Creating $repo backup directory..."
      mkdir $backup_path
    fi
    setopt errreturn
    mv $TMPDIR/$backup_file $backup_path
    gzip -f9 $backup_path/$backup_file
    print $fg[green]Backup is ready:$reset_color
    ln -nvfs $backup_path/$backup_file.gz $backup_path/last.sql.gz
  else
    rm $TMPDIR/$backup_file
    pe $fg[red]Failed.$reset_color;
  fi
}
compctl -x 'p[1]' -g "$MYSQL_BACKUP_PATH/*(/:t)" -- mysqlbackup

# Backup databases.
mysqlrestore() {
  local backup_project_path backup_file repo pw
  if [[ -z $1 ]]; then
    repo=$(basename $(g rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
    if [[ -z $repo ]]; then
      p $MYSQL_BACKUP_PATH/*(/:t)
      return 1
    fi
  else
    repo=$1
  fi

  backup_project_path=$MYSQL_BACKUP_PATH/$repo
  backup_file=$(readlink $backup_project_path/last.sql.gz)
  if [[ ! -f $backup_file ]]; then
    pe $fg[red]Backup not found.$reset_color;
    return 1
  fi

  print $fg[magenta]"Warning! Removing \e[48;5;052m $repo ${bg[default]} database!"$reset_color;
  read -s 'pw?Enter password: '
  p

  mysqladmin --force -u root -p$pw drop $repo create $repo
  if [[ $? != 0 ]]; then
    pe $fg[red]Failed.$reset_color;
    return 1
  fi

  print Restoring from $backup_file
  gzcat $backup_file | mysql -u root -p$pw $repo
  if [[ $? == 0 ]]; then
    print $fg[green]Backup has been restored.$reset_color
  else
    pe $fg[red]Failed.$reset_color;
  fi
}
compctl -x 'p[1]' -W $MYSQL_BACKUP_PATH -/ -S " " - -- mysqlrestore


# Dump and diff.
mysqldiff() {
  setopt localoptions errreturn
  local repo table backup_path backup_file dump_file name result
  if [[ -z $1 ]]; then
    pe "usage: $0 <table|-a>"
    return 1
  fi
  if [[ $1 == "-a" ]]; then
    table=""
    name="all"
  else
    table=$1
    name=$1
  fi

  repo=$(basename $(g rev-parse --show-toplevel))
  backup_path="$MYSQL_BACKUP_PATH/$repo"
  backup_file="$backup_path/$name.sql"
  dump_file="$TMPDIR/${repo}_$name.sql"

  mysqldump -t --single-transaction --compact \
    --skip-extended-insert $repo $table > $dump_file

  touch $backup_file
  gdw $backup_file $dump_file && return || true
  print -n "Save (y/n)? "
  read -q && result=1 || result=0
  p

  if [[ $result == 1 ]]; then
    if [[ ! -d $backup_path ]]; then
      p "Creating $repo backup directory..."
      mkdir $backup_path
    fi
    mv $dump_file $backup_file
    print "Dumped to $backup_file"
  fi
}

############ Android.
# Adb logcat
lc() {
  if [[ $1 == "--help" ]]; then
    pe "usage: $0 [global-loglevel: v, d, i, w, e, f] [options] [#grep]"
    return 1
  fi
  local opts loglevels tag
  loglevels=(v d i w e f)
  opts=($@)
  tag=""

  if [[ -n $1 ]]; then
    # loglevel
    if [[ ${loglevels[(r)${opts[1]}]} == ${opts[1]} ]]; then
      opts[1]="*:${opts[1]}"
    else
      opts=("-s" ${opts})
    fi
    # grep tag
    if [[ ${opts[-1][1]} == "#" ]]; then
      tag=${opts[-1][2,-1]}
      opts[-1]=""
    fi
  fi

  if [[ ${tag} == "" ]]; then
    # echo ${opts}
    adb logcat ${opts} | coloredlogcat.py
  else
    if [[ "${opts}" == "-s " ]]; then
      opts=""
    fi
    # echo ${opts}
    # echo ${tag}
    adb logcat ${opts} | grep --line-buffered ${tag} | coloredlogcat.py
  fi
}
alias lc="noglob lc"


a-s() {

}
