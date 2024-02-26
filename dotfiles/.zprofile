# https://github.com/rbenv/rbenv/issues/369#issuecomment-36010083
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# MacPorts Installer addition on 2021-01-21_at_11:32:34: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2021-01-21_at_11:32:34: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.
