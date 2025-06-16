#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#   * One line.
#   * VCS info on the right prompt.
#   * Only shows the path on the left prompt by default.
#   * Crops the path to a defined length and only shows the path relative to
#     the current VCS repository root.
#   * Wears a different color wether the last command succeeded/failed.
#   * Shows user@hostname if connected through SSH.
#   * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END='❯'
PROMPT_ROOT_END='❯❯❯'
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$fg[red]

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

local prompt_vcs
prompt_vcs=("%{$FG[081]%}%b "
            "%{$FG[211]%}%r"
            "%{$reset_color%} "
            "%{$FG[172]%}%u"
            "%{$FG[112]%}%c"
            "%{$reset_color%}")

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr $'\U26a1'
zstyle ':vcs_info:*:*' stagedstr '＋'
zstyle ':vcs_info:*:*' actionformats "%S" "${(j::)prompt_vcs} (%a)"
zstyle ':vcs_info:*:*' formats "%S" "${(j::)prompt_vcs}"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Define prompts.
PROMPT=$'%{\033]133;A\007%}'"%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$reset_color%} "
RPROMPT='${vcs_info_msg_1_}'

# LSCOLORS=exfxcxdxbxegedabagacad
# export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
# export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
