# zsh-sergiis-plugin
My oh-my-zsh setup

```
# Install plugin
cd ~/.oh-my-zsh/custom/plugins
git clone git@github.com:sergii-tkachenko/zsh-sergiis-plugin.git

# Install theme
cd ~
cp ~/.oh-my-zsh/custom/plugins/zsh-sergiis-plugin/dotfiles/themes/sergii2.zsh-theme ~/.oh-my-zsh/themes

# .zshrc, enables this plugin and theme
mv ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/custom/plugins/zsh-sergiis-plugin/dotfiles/.zshrc ~/.zshrc

# .profile
mv ~/.profile ~/.profile.orig
mkdir ~/bin
mkdir ~/.npm-packages
cp ~/.oh-my-zsh/custom/plugins/zsh-sergiis-plugin/dotfiles/.profile ~/.profile
```
