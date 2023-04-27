# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"
ZLE_RPROMPT_INDENT=1

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

### Plugins config

# FZF
export FZF_BASE=/opt/local/share/fzf
export FZF_DEFAULT_OPTS='--layout=reverse --border'
export FZF_COMPLETION_TRIGGER='\\'
# Because completions is in unusual place
# export DISABLE_FZF_AUTO_COMPLETION='true'
# source /opt/local/share/zsh/site-functions/_fzf
# source /opt/local/share/fzf/shell/completion.zsh

# Gcloud
export CLOUDSDK_HOME=$HOME/Development/SDK/google-cloud-sdk

# Tmux
# export ZSH_TMUX_ITERM2=true
# export ZSH_TMUX_FIXTERM=false
# export ZSH_TMUX_FIXTERM_WITHOUT_256COLOR=xterm
# export ZSH_TMUX_FIXTERM_WITH_256COLOR=xterm-256color

# https://github.com/zsh-users/zsh-autosuggestions#suggestion-highlight-style
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(macos macports sublime \
         history-substring-search extract \
         zsh-autosuggestions zsh-syntax-highlighting fzf \
         git \
         gradle gcloud kubectl \
         zsh-sergiis-plugin
)
# Use bat instead of colored-man-pages plugin
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\"'"

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# Load macports autocomplete
fpath=(/opt/local/share/zsh/site-functions $fpath)

source ~/.profile
source $ZSH/oh-my-zsh.sh

setopt nonomatch

# zsh-syntax-highlighting settings
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
ZSH_HIGHLIGHT_STYLES[command]='fg=010,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=010,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=010,bold,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=051,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=087'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=087,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=227'
ZSH_HIGHLIGHT_STYLES[assign]='fg=204'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[default]='fg=195'

### User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# TL;DR autocomplete
source /opt/local/share/tldr-cpp-client/autocomplete/complete.zsh

# https://github.com/romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Proprietary costumizations
source ~/.work-custom.zshrc
# contains MDPROXY-ZSHRC
