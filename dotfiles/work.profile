# MacPorts Installer addition on 2017-07-02_at_13:22:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Macport libs
export CXXFLAGS="-I/opt/local/include"
export LDFLAGS="-L/opt/local/lib"


# Home
PATH=$HOME/.bin:$PATH

# Java MacPorts
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk8/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk11/Contents/Home
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk14/Contents/Home"

# Android MacPorts
export ANDROID_HOME=$HOME/Development/Android/sdk/
PATH=$PATH:$HOME/Development/Android/sdk/cmdline-tools/latest/bin/
PATH=$PATH:$HOME/Development/Android/sdk/platform-tools

# Env
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export EDITOR="sublw"

# Python
export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.8/bin"
# export PATH="/Users/sergii/Library/Python/3.8/bin:$PATH"

# authrefresh
export AUTH_HOST=sergiitk.c.googlers.com

# SSH
# Load SSH keys stored in the Keychain using native OSX ssh agent
/usr/bin/ssh-add -A &> /dev/null
# ssh-add -K > /dev/null 2>&1
