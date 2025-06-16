## Work Profile: .profile
## -------------------------------------------------------------------------------------------------

# Home folder setup
PATH="${HOME}/.bin/gobin:${HOME}/.bin/gnu:${HOME}/.bin:${PATH}"

# XDG
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://gist.github.com/roalcantara/107ba66dfa3b9d023ac9329e639bc58c
# For XDG_BIN_HOME:
# lk ~b ~/.local/bin

# Env
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"
export EDITOR="sublw"

# Macport libs
export CXXFLAGS="-I/opt/local/include"
export LDFLAGS="-L/opt/local/lib"

# Java MacPorts
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk8-temurin/Contents/Home
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk11-temurin/Contents/Home"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk17-temurin/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21-eclipse-temurin.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-22-eclipse-temurin.jdk/Contents/Home"

# Android
export ANDROID_HOME="${HOME}/Development/Android/sdk"
PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
PATH="${PATH}:${ANDROID_HOME}/platform-tools"

# Python
# User site: python -m site --user-base
# https://packaging.python.org/en/latest/tutorials/installing-packages/#installing-to-the-user-site
# https://docs.astral.sh/uv/concepts/tools/#the-bin-directory
export PATH="${HOME}/Library/Python/3.12/bin:$PATH"

# Gcloud
export CLOUDSDK_HOME="${HOME}/Development/SDK/google-cloud-sdk"

# SSH
# Load SSH keys stored in the Keychain using native OSX ssh agent
# replaced with bin/ssh-load-keychain
# /usr/bin/ssh-add -A &> /dev/null
