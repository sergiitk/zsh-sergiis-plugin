## Home Profile: .profile
## -------------------------------------------------------------------------------------------------

# Home folder setup
PATH="${HOME}/.bin/gnu:${HOME}/.bin:${PATH}"

## XDG
# https://specifications.freedesktop.org/basedir-spec/latest/

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

# XDG_BIN_HOME - not in the spec yet, but see the following for other non-official XDG_ vars:
# https://gist.github.com/roalcantara/107ba66dfa3b9d023ac9329e639bc58c
# For XDG_BIN_HOME: lk ~b ~/.local/bin, or
# export PATH="${HOME}/.local/bin:${PATH}"

# Env
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"
export EDITOR="sublw"

# Java Macports
# https://whichjdk.com/
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21-eclipse-temurin.jdk/Contents/Home"

# Python
# User site: python -m site --user-base
# https://packaging.python.org/en/latest/tutorials/installing-packages/#installing-to-the-user-site
# https://docs.astral.sh/uv/concepts/tools/#the-bin-directory
# export PATH="${HOME}/Library/Python/3.12/bin:$PATH"
#
# Python Macports
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin"
