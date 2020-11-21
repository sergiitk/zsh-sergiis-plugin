# Completions.

# Hosts: Use /etc/hosts and known_hosts for hostname completion.
 # [ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
 # [ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
 # hosts=(
 #   "$_ssh_hosts[@]"
 #   "$_etc_hosts[@]"
 # )
 # zstyle ':completion:*:hosts' hosts $hosts
 # zstyle ':completion:*' users off

 # zstyle ':completion:*' use-perl on
 # zstyle ':completion:*' menu select

 # insert all expansions for expand completer
 # zstyle ':completion:*:expand:*' keep-prefix true tag-order all-expansions

 # formatting and messages
 # zstyle ':completion:*' verbose yes
 # zstyle ':completion:*:descriptions' format "- %{${fg[yellow]}%}%d%{${reset_color}%} -"
 # zstyle ':completion:*:messages' format '%d'
 # zstyle ':completion:*:warnings' format 'No matches for: %d'
 # zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
 # zstyle ':completion:*' group-name ''
 # zstyle ':completion:*' list-separator '#'
 # zstyle ':completion:*' auto-description 'specify: %d'
 # zstyle ':completion:*:default' list-prompt '%S%M matches%s'
 # zstyle ':completion:*:prefix:*' add-space true

 # Make the nice with git completion and others
 # zstyle ':completion::*:(git|less|rm|emacs)' ignore-line true

 # SSH Completion
# zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
# zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users

 # zstyle ':completion:*:scp:*' tag-order files 'hosts:-domain:domain'
 # zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
 # zstyle ':completion:*:ssh:*' tag-order 'hosts:-domain:domain'
 # zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
 # Highlight the current autocomplete option
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# # Better SSH/Rsync/SCP Autocomplete
# zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
# zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
# zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# # Allow for autocomplete to be case insensitive
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
#   '+l:|?=** r:|?=**'

# Initialize the autocompletion
# autoload -Uz compinit && compinit -i
# _sshosts=()
# # if [[ -r ~/.ssh/config ]]; then
# #   _sshosts=($_sshosts ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
# # fi
# if [[ -r ~/.ssh/known_hosts ]]; then
#   _sshosts=($_sshosts ${${${(f)"$(cat ~/.ssh/known_hosts || true)"}%%\ *}%%,*}) 2>/dev/null
# fi
# if [[ $#_sshosts -gt 0 ]]; then
#   zstyle ':completion:*:ssh:*' hosts $_sshosts
#   zstyle ':completion:*:slogin:*' hosts $_sshosts
# fi

 ### highlight parameters with uncommon names
 # zstyle ':completion:*:parameters' list-colors "=[^a-zA-Z]*=$color[red]"

 ### highlight aliases
 # zstyle ':completion:*:aliases' list-colors "=*=$color[green]"

 ### highlight the original input.
 # zstyle ':completion:*:original' list-colors "=*=$color[red];$color[bold]"

 ### highlight words like 'esac' or 'end'
 # zstyle ':completion:*:reserved-words' list-colors "=*=$color[red]"

 ### colorize hostname completion
 # zstyle ':completion:*:*:*:*:hosts' list-colors "=*=$color[cyan];$color[bg-black]"

 # Disable completion of usernames
 # zstyle ':completion:*' users off

 ## add colors to processes for kill completion
 # zstyle ':completion:*:*:kill:*' verbose yes
 # zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#) #([^ ]#)*=$color[cyan]=$color[yellow]=$color[green]"

 ## With commands like `rm' it's annoying if one gets offered the same filename
 ## again even if it is already on the command line. To avoid that:
 # zstyle ':completion:*:rm:*' ignore-line yes

 ## Manpages, ho!
 # zstyle ':completion:*:manuals'       separate-sections true
 # zstyle ':completion:*:manuals.(^1*)' insert-sections   true
