# MacPorts Installer addition on 2017-07-02_at_13:22:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Home
PATH=$HOME/.bin:$PATH

# Java Macports
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk8/Contents/Home
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk14/Contents/Home"

# Env
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export EDITOR="sublw"

# Python
export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.8/bin"
# export PATH="/Users/sergii/Library/Python/3.8/bin:$PATH"

# SSH
# Load SSH keys stored in the Keychain using native OSX ssh agent
/usr/bin/ssh-add -A &> /dev/null
# ssh-add -K > /dev/null 2>&1
