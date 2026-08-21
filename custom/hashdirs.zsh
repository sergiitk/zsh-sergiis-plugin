## Custom named directory hash table.
## -------------------------------------------------------------------------------------------------
#
# To undo the ~ for a path, you can use print -D:
# $ print -D /Users/sergiitk/Development/grpc
# ~d/grpc
#
# This also can be done using var parameter expansion flags
# $ my_dir="/Users/sergiitk/Development/grpc"
# $ echo "${(D)my_dir}"
# ~d/grpc
## -------------------------------------------------------------------------------------------------


### Apple and their weird folders...
# Homedir Library
hash -d libas="${HOME}/Library/Application Support"
# iCloud drive
hash -d icloud="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/"

### User home shortcuts
hash -d b="${HOME}/.bin"
hash -d c="${HOME}/.config"
hash -d r="${HOME}/Downloads/__remove"

### Development
# alias dev='cd ~/Development'
hash -d d="${HOME}/Development"
hash -d dev="${HOME}/Development"
hash -d play="${HOME}/Development/playground"
hash -d p="${HOME}/Development/projects"
hash -d g="${HOME}/.gemini/config"
hash -d go="${HOME}/Development/go"
hash -d gb="${HOME}/Development/go/packages/bin"

### MacPorts
hash -d o=/opt/local
hash -d oe=/opt/local/etc
hash -d ol=/opt/local/var/log
