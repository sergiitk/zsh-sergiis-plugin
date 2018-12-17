# SSH
# ssh-add -K > /dev/null 2>&1

# MacPorts Installer addition on 2017-07-02_at_13:22:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Home.
PATH=$HOME/.bin:$PATH

# https://rvm.io/

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


# Composer.
# https://getcomposer.org/doc/03-cli.md#composer-home
# export COMPOSER_HOME="$HOME/Development/PHP/Composer"

# Env.
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export EDITOR="sublw"

# Gems.
# export GEM_HOME=/Users/sergii/.rubygems
# export GEM_PATH=/Users/sergii/.rubygems:/opt/local/lib/ruby1.9/gems/1.9.1

# Gisty.
# https://github.com/swdyh/gisty
# export GISTY_DIR="$HOME/Development/Archive/gists"
# export GISTY_ACCESS_TOKEN="1c9d9c1cc4f25f61903e570840952f03198c40e5"

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Python
export PYTHONUSERBASE="/Users/sergii/Development/python/userbase"
export PATH="/Users/sergii/Development/python/userbase/bin:$PATH"
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin"
# export PIPENV_SHELL_COMPAT=true
# export PATH="$PATH:$HOME/Library/Python/2.7/bin" # Add RVM to PATH for scripting
# /opt/local/Library/Frameworks/Python.framework/Versions/3.6/bin

# PHP
# export PATH="$PATH:$HOME/.composer/vendor/bin" # Add RVM to PATH for scripting
