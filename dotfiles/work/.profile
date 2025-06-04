# Macport libs
export CXXFLAGS="-I/opt/local/include"
export LDFLAGS="-L/opt/local/lib"

# Home
PATH="${HOME}/.bin/gobin:${HOME}/.bin/gnu:${HOME}/.bin:${PATH}"

# Env
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"
export EDITOR="sublw"

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

# Gcloud
export CLOUDSDK_HOME="${HOME}/Development/SDK/google-cloud-sdk"

# Python
# Normally /.local/bin
# python -m site --user-base
export PATH="/Users/sergiitk/Library/Python/3.12/bin:$PATH"

# SSH
# Load SSH keys stored in the Keychain using native OSX ssh agent
# replaced with bin/ssh-load-keychain
# /usr/bin/ssh-add -A &> /dev/null
