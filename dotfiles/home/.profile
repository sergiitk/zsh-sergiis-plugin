# MacPorts Installer addition on 2017-07-02_at_13:22:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Home
PATH="${HOME}/.bin/gnu:${HOME}/.bin:${PATH}"

# Env
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"
export EDITOR="sublw"

# Java Macports
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk8/Contents/Home
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk14/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk17/Contents/Home"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk17-zulu/Contents/Home
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21-azul-zulu.jdk"

alias source-nvm='source /opt/local/share/nvm/init-nvm.sh'
# Node
# source /opt/local/share/nvm/init-nvm.sh
#
# # NPM packages in homedir
# NPM_PACKAGES="$HOME/.npm-packages"
# # Tell our environment about user-installed node tools
# PATH="$NPM_PACKAGES/bin:$PATH"
# # Unset manpath so we can inherit from /etc/manpath via the `manpath` command
# unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
# MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# # Tell Node about these packages
# NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# Python
# export PATH="/Users/sergii/Library/Python/3.8/bin:$PATH"
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.8/bin"
