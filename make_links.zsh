#!/usr/bin/env zsh
THIS_PATH=`dirname $0:A`

echo "Creating symlinks..."
echo
ln -sf ${THIS_PATH}/zsh/.zshenv ~/.zshenv
ln -sf ${THIS_PATH}/zsh/.zshrc ~/.zshrc
ln -sf ${THIS_PATH}/zsh/.zshrc.pre-oh-my-zsh ~/.zshrc.pre-oh-my-zsh

ln -sf ${THIS_PATH}/vcs/.gitconfig ~/.gitconfig
ln -sf ${THIS_PATH}/vcs/.gitignore_global ~/.gitignore_global
ln -sf ${THIS_PATH}/vcs/.hgignore_global ~/.hgignore_global
ln -sf ${THIS_PATH}/vcs/.hgrc ~/.hgrc

ln -sf ${THIS_PATH}/vim/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -sf ${THIS_PATH}/nvim/init.vim ~/.config/nvim/init.vim

ln -sf ${THIS_PATH}/emacs/.spacemacs ~/.spacemacs

ln -sf ${THIS_PATH}/shell/.profile ~/.profile
ln -sf ${THIS_PATH}/X/.xinitrc ~/.xinitrc
ln -sf ${THIS_PATH}/X/.xprofile ~/.xprofile
ln -sf ${THIS_PATH}/X/.Xresources ~/.Xresources

if [ ! -d ~/.i3 ]; then
  ln -sf ${THIS_PATH}/i3 ~/.i3
fi
mkdir -p ~/.config/gtk-3.0
ln -sf ${THIS_PATH}/gtk3/settings.ini ~/.config/gtk-3.0/settings.ini
