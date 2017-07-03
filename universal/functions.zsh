################### Universal Functions  ###################
# Searches in aliases.
# Please make sure GNU version is used: `port echo installed | grep grep`.
ls-alias() {
  alias | grep -P "(?<!(\w|-))$argv(?!\w)"
}
alias ls-alias="nocorrect ls-alias"

# Searches in vars.
# Please make sure GNU version is used: `port echo installed | grep grep`.
ls-vars() {
  set | grep --color=always -ia $1 | grep -Ev "(_comps|^\@|^'\*'|^argv|^_history_substring_|^portlist)"
}

# Search through all binaries.
ls-bin() {
  CLICOLOR_FORCE=1 ls -l ${^path}/*$1*(N) | awk '{ print $9" "$10" "$11 }'
}

############ Other utilities.
# Show oh-my-zsh changes.
oh-my-changes() {
  if [[ -z $1 ]]; then
    echo "Commits to inspect, eg. b51c2a0..61e3951"
    return
  fi
  local plugins_changed
  plugins_changed=$(comm -12 <(git --git-dir=$ZSH/.git diff --name-only $1 -- plugins | cut -d/ -f2 | sort -u) <(print -l $plugins | sort -u))
  if [[ -z $plugins_changed ]]; then
    print "\e[32mNothing new.\e[0m"
    return
  fi
  git --git-dir=$ZSH/.git diff -U0 --abbrev --color-words $1 -- plugins/${^${(f)plugins_changed}}
}

# Check dot files.
checkdot() {
  print -l ~/.!(netextender|DS_Store|CFUserTextEncoding|curlrc|gemrc|gitconfig|irb-history|lesshst|mysql_history|netrc|pearrc|profile|pry_history|psql_history|rdebug_hist|rnd|sqlite_history|viminfo|vimrc|wgetrc|zcompdump-*|zlogin|zsh-update|zsh_history|zshrc|npmrc|gitignore_global)(.N)
}

# Check dot files.
checkdotdirs() {
  print -l ~/.!(ansible|adobe|bundle|config|cups|composer|drush|dropbox|dropbox-master|gem|heroku|oh-my-zsh|rvm|ssh|subversion|Trash|vim|vagrant.d|npm)(/N)
}

gdu.() {
  _ echo -n $PWD": "
  _ gdu --si --summarize --total --threshold=10m *(/ND^@^F) | gsort -h -r | column -t -s$'\t'
}

cmn() {
  local result=""
  for i in $@
  do
      result="${result} \$${i} \" \""
  done
  # echo $result
  awk "{ print ${result} }" - | column -t
}

serialize-to-json() {
  php -R 'echo json_encode(unserialize($argn), JSON_PRETTY_PRINT);'
  echo
}

serialize-to-json-and-copy() {
  local result=""
  result=$(pbpaste | php -R 'echo json_encode(unserialize($argn), JSON_PRETTY_PRINT);')
  echo $result | pbcopy
  echo $result
  echo
}

json-to-serialize() {
  php -R 'var_export(json_decode($argn));'
  echo
}

json-to-serialize-and-copy() {
  local result=""
  result=$(pbpaste | php -R 'var_export(json_decode($argn));')
  echo $result | pbcopy
  echo $result
  echo
}

siege-to-spreadsheet() {
  local result=""
  result=$(pbpaste | cut -d":" -f2 | awk {'print $1'} | xargs -n1 -I{} printf '{}\t' | sed 's/;$//')
  echo -n $result | pbcopy
  echo $result
}
