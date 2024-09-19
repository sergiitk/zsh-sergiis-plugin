# Macport libs
export CXXFLAGS="-I/opt/local/include"
export LDFLAGS="-L/opt/local/lib"

# Home
PATH="${HOME}/.bin:${PATH}"

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
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.8/bin"
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.10/bin"
# export PATH="/Users/sergii/Library/Python/3.8/bin:$PATH"

# SSH
# Load SSH keys stored in the Keychain using native OSX ssh agent
/usr/bin/ssh-add -A &> /dev/null
# ssh-add -K > /dev/null 2>&1
