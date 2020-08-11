# MacPorts Installer addition on 2017-07-02_at_13:22:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Home.
PATH=$HOME/.bin:$PATH

# Env.
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export EDITOR="sublw"

# Android.
# SDK
# export ANDROID_SDK=$HOME/Development/Android/SDK
# PATH=$PATH:$HOME/Development/Android/SDK/tools
# PATH=$PATH:$HOME/Development/Android/SDK/platform-tools
# Nexus.
# export PLEXUS_NEXUS_WORK="$HOME/Development/Android/Tools/Nexus-Repo"

# NPM.
# PATH=$PATH:$HOME/node_modules/.bin
# NPM packages in homedir
NPM_PACKAGES="$HOME/.npm-packages"
# Tell our environment about user-installed node tools
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# Tell Node about these packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# Python
export PATH="/Users/sergii/Library/Python/3.8/bin:$PATH"
export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.8/bin"

# export PYTHONUSERBASE="/Users/sergii/Development/python/userbase"
# export PATH="/Users/sergii/Development/python/userbase/bin:$PATH"
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin"
# export PIPENV_SHELL_COMPAT=true
# export PATH="$PATH:$HOME/Library/Python/2.7/bin" # Add RVM to PATH for scripting
# /opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin

# SSH
# ssh-add -K > /dev/null 2>&1
