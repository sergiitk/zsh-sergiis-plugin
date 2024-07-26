################### OSX Functions  ###################
# Search through ports.
psearch() {
  local context
  local ignore;
  if [[ -z $1 ]]; then
    echo "p-search [^]pattern [-v] [-d]"
    echo " ^  - matches that start with pattern"
    echo " -d - don't match subports"
    echo " -v - verbose"
    return
  fi
  if [[ $2 == "-v" || $2 == "-dv" ]]; then
    context="-A1"
  fi
  if [[ $2 == "-d" || $2 == "-dv" ]]; then
    ignore="-"
  fi
  port search ${1//[^a-zA-Z0-9_-]/} | grep -iP $context "$1[^ $ignore]*(?= @[0-9])"
}
alias psearch="noglob psearch"

# Setup proxy from system.
proxysetup() {
  if [[ `scutil --proxy | grep HTTPEnable | cut -d: -f2 | tr -d " "` -eq '1' ]]; then
    local url=`scutil --proxy | grep 'HTTP[Port|Proxy]' | sort -r | sed 's/^.*: *//' | sed 'N;s/\n/:/'`
    export rsync_proxy=$url
    export {http,ftp}_proxy=http://$url
    echo "rsync:\t$rsync_proxy"
    echo "http:\t$http_proxy"
    echo "ftp:\t$ftp_proxy"
  else
    echo "rsync:\tdisabled"
    echo "http:\tdisabled"
    echo "ftp:\tdisabled"
    unset {http,ftp,rsync}_proxy
  fi
  if [[ `scutil --proxy | grep HTTPSEnable | cut -d: -f2 | tr -d " "` -eq '1' ]]; then
    export https_proxy=http://`scutil --proxy | grep 'HTTPS[Port|Proxy]' | sort -r | sed 's/^.*: *//' | sed 'N;s/\n/:/'`
    echo "https:\t$http_proxy"
  else
    echo "https:\tdisabled"
    unset https_proxy
  fi
}

# Open man file as html in the default browser.
manhtml() {
  if [[ -z $1 ]]; then
    echo "What manual page do you want?"
    return
  fi
  local manpage=$(man -w $1)
    if [[ -z $1 ]]; then
    echo "No manual entry for $1."
    return
  fi
  local manoutputdir=$TMPDIR/manhtml
  if [[ ! -d $manoutputdir ]]; then
    mkdir $TMPDIR/manhtml || exit 1
  fi
  local manoutputfile=$manoutputdir/$1.html
  if [[ ! -a $manoutputfile ]]; then
    groffer --www --www-viewer cat $manpage > $manoutputfile
  fi
  open $manoutputfile
}
compdef manhtml=man-preview

# MacPorts deamons relaunch.
relaunch() {
  if [[ -z $1 ]]; then
    p /opt/local/etc/LaunchDaemons/org.macports.*(:t) | cut -d. -f3
    return 1
  fi

  result() {
    if [[ ! -n $@ ]];
      then print $fg[green]OK$@$reset_color;
      else print $fg[red]$@$reset_color;
    fi
  }

  print -n "Unloading $1... "
  result $(sudo port unload $1 2>&1)

  print -n "Loading $1... "
  result $(sudo port load $1 2>&1)
}
compdef relaunch=port-deamons

port-start() {
  sudo port load $*
}
compdef port-start='port-deamons'

port-stop() {
  sudo port unload $*
}
compdef port-stop='port-deamons'

iterm-toggle-mode() {
  local value;
  value=$(defaults read /Applications/iTerm.app/Contents/Info LSUIElement)
  if [[ $value == "1" ]]; then
    echo "LSUIElement mode: $fg[red]off$@$reset_color"
    value="0"
  else
    echo "LSUIElement modeL: $fg[green]on$@$reset_color"
    value="1"
  fi
  defaults write /Applications/iTerm.app/Contents/Info LSUIElement $value
  echo "Please restart iTerm2"
}

int-to-float() {
  python -c 'import sys, struct; print(format(struct.unpack(">f", struct.pack(">l", int(sys.stdin.read())))[0], ".2f"))'
}

get-adapter-power() {
  ioreg -rw0 -a -c AppleSmartBattery |\
   plutil -extract '0.BatteryData.AdapterPower' raw - | int-to-float
}

get-system-power() {
  ioreg -rw0 -a -c AppleSmartBattery |\
   plutil -extract '0.BatteryData.SystemPower' raw - | int-to-float
}

get-adapter-mode() {
  local watts
  watts=$(ioreg -rw0 -a -c AppleSmartBattery | plutil -extract '0.AdapterDetails.Watts' raw - 2> /dev/null)
  if (( $? == 0 )); then
    echo $watts
  else
    echo "-1"
  fi
}


get-power() {
  echo "Adapter:  $(get-adapter-mode) W"
  echo "Using:    $(get-system-power) W"
  echo "Charging: $(get-adapter-power) W"
}
