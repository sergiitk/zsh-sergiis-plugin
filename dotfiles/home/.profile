## Home Profile: .profile
## -------------------------------------------------------------------------------------------------

# Home folder setup
PATH="${HOME}/.bin/gnu:${HOME}/.bin:${PATH}"

# XDG
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://gist.github.com/roalcantara/107ba66dfa3b9d023ac9329e639bc58c
# For XDG_BIN_HOME:
# lk ~b ~/.local/bin

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
