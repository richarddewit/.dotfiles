#!/usr/bin/env zsh
THIS_PATH=`dirname $0:A`

echo "Creating symlinks..."
echo
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
