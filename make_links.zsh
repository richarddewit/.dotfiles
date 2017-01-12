#!/usr/bin/env zsh
THIS_PATH=`dirname $0:A`

echo "Creating symlinks..."
echo

# Create necessary folders
mkdir -p ~/{.i3,.config/{nvim,compton,dunst,gtk-3.0,termite}}

ln -sf ${THIS_PATH}/zsh/.zshenv ~/.zshenv
ln -sf ${THIS_PATH}/zsh/.zshrc ~/.zshrc
ln -sf ${THIS_PATH}/zsh/.zshrc.pre-oh-my-zsh ~/.zshrc.pre-oh-my-zsh

ln -sf ${THIS_PATH}/vcs/.gitconfig ~/.gitconfig
ln -sf ${THIS_PATH}/vcs/.gitignore_global ~/.gitignore_global
ln -sf ${THIS_PATH}/vcs/.hgignore_global ~/.hgignore_global
ln -sf ${THIS_PATH}/vcs/.hgrc ~/.hgrc

ln -sf ${THIS_PATH}/vim/.vimrc ~/.vimrc
ln -sf ${THIS_PATH}/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ${THIS_PATH}/emacs/.spacemacs ~/.spacemacs

ln -sf ${THIS_PATH}/atom/.proton ~/.proton
ln -sf ${THIS_PATH}/atom/init.coffee ~/.atom/init.coffee
ln -sf ${THIS_PATH}/atom/snippets.cson ~/.atom/snippets.cson
ln -sf ${THIS_PATH}/atom/styles.less ~/.atom/styles.less

ln -sf ${THIS_PATH}/shell/.profile ~/.profile
ln -sf ${THIS_PATH}/X/.xinitrc ~/.xinitrc
ln -sf ${THIS_PATH}/X/.xprofile ~/.xprofile
ln -sf ${THIS_PATH}/X/.Xresources ~/.Xresources
ln -sf ${THIS_PATH}/X/compton.conf ~/.config/compton/compton.conf

ln -sf ${THIS_PATH}/i3/config ~/.i3/config
ln -sf ${THIS_PATH}/i3/i3exit.sh ~/.i3/i3exit.sh
ln -sf ${THIS_PATH}/i3/i3lock.sh ~/.i3/i3lock.sh
ln -sf ${THIS_PATH}/i3/screen-lock.png ~/.config/screen-lock.png
ln -sf ${THIS_PATH}/i3/conky_status.conf ~/.i3/conky_status.conf
ln -sf ${THIS_PATH}/i3/conky_status.sh ~/.i3/conky_status.sh
ln -sf ${THIS_PATH}/i3/dunstrc ~/.config/dunst/dunstrc
if [ ! -d ~/.i3/lemonbar ]; then
  ln -sf ${THIS_PATH}/i3/lemonbar ~/.i3/lemonbar
fi
if [ ! -d ~/.i3/status ]; then
  ln -sf ${THIS_PATH}/i3/status ~/.i3/status
fi

if [ ! -d ~/scripts ]; then
  ln -sf ${THIS_PATH}/scripts ~/scripts
fi

ln -sf ${THIS_PATH}/gtk3/settings.ini ~/.config/gtk-3.0/settings.ini
ln -sf ${THIS_PATH}/widgets/gsimplecal.conf ~/.config/gsimplecal/config
ln -sf ${THIS_PATH}/termite/config ~/.config/termite/config

echo "OK done"
