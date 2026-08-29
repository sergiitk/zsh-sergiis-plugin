## Home Profile: .profile
## -------------------------------------------------------------------------------------------------

# Re-source the .zshenv file so we get our path in the beginning instead of getting borked by
# /usr/libexec/path_helper -s from /etc/profile
if [[ -f "${HOME}/.oh-my-zsh/custom/plugins/zsh-sergiis-plugin/dotfiles/home/.zshenv" ]]; then
    # shellcheck disable=SC1091
    source "${HOME}/.oh-my-zsh/custom/plugins/zsh-sergiis-plugin/dotfiles/home/.zshenv"
fi

# Env
export EDITOR="sublw"

# MacPorts libs
export CXXFLAGS="-I/opt/local/include"
export LDFLAGS="-L/opt/local/lib"

# Java Macports
# https://whichjdk.com/
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21-eclipse-temurin.jdk/Contents/Home"

# Python
# User site: python -m site --user-base
# https://packaging.python.org/en/latest/tutorials/installing-packages/#installing-to-the-user-site
# https://docs.astral.sh/uv/concepts/tools/#the-bin-directory
# export PATH="${HOME}/Library/Python/3.12/bin:$PATH"
#
# Python Macports
# export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin"
