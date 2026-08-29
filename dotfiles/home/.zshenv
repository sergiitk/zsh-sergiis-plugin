## The order of .z* files: https://unix.stackexchange.com/a/71258
## (1) .zshenv - always sourced, often contains exported vars, f.e. $PATH, $EDITOR.
## -------------------------------------------------------------------------------------------------

## Standard Environment
## -------------------------------------------------------------------------------------------------
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"

## XDG
# Official spec: https://specifications.freedesktop.org/basedir-spec/latest/
# Non-official, but common: https://gist.github.com/roalcantara/107ba66dfa3b9d023ac9329e639bc58c
## -------------------------------------------------------------------------------------------------

# XDG_CONFIG_HOME
# Apparently this is _sometimes_ respected, but not by go or rust directories, unfortunately.
# Go and rust default straight to ~libas on mac.
#
# Fun rabbithole on why bat (which is using rust directories) does use ~/.config/bat/:
# - https://github.com/sharkdp/bat/issues/151 (first request)
# - https://github.com/sharkdp/bat/issues/442 (issue by the maintainer)
# - https://github.com/sharkdp/bat/pull/491   (the PR)
#
# Still, setting it just in case someone chooses to respect it.
export XDG_CONFIG_HOME="${HOME}/.config"

# XDG_BIN_HOME - not in the spec yet.
export XDG_BIN_HOME="${HOME}/.local/bin"


## MacPorts
## -------------------------------------------------------------------------------------------------

# MacPorts Installer addition on 2021-01-21_at_11:32:34: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:${PATH}"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2021-01-21_at_11:32:34: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.


## Home folder paths and final export
# We need to keep it at the end
## -------------------------------------------------------------------------------------------------

## Home folder binaries
# .bin/       - My scripts, including those from $ZSH_SERGII/bin (via symlinks)
# .bin/gnu/   - Override BSD tools with symlinks to GNU, e.g. find -> /opt/local/bin/gfind
# .bin/gobin/ - Go binaries symlinks, e.g. buildifier -> ~go/packages/bin/buildifier
export PATH="${HOME}/.bin:${HOME}/.bin/gnu:${HOME}/.bin/gobin:${XDG_BIN_HOME}:${PATH}"
