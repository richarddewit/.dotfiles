#!/usr/bin/env zsh
echo "  ____  _      _                   _ _";
echo " |  _ \(_) ___| |__   __ _ _ __ __| ( )___";
echo " | |_) | |/ __| '_ \ / _\` | '__/ _\` |// __|";
echo " |  _ <| | (__| | | | (_| | | | (_| | \__ \\";
echo " |_| \_\_|\___|_| |_|\__,_|_|  \__,_| |___/";
echo "       _       _    __ _ _";
echo "    __| | ___ | |_ / _(_) | ___  ___";
echo "   / _\` |/ _ \| __| |_| | |/ _ \/ __|";
echo "  | (_| | (_) | |_|  _| | |  __/\__ \\";
echo " (_)__,_|\___/ \__|_| |_|_|\___||___/";
echo
echo " Author: Richard de Wit";
echo " Repo:   https://github.com/richarddewit/.dotfiles";
echo

THIS_PATH=`dirname $0:A`

echo "Creating symlinks..."
echo
ln -sf ${THIS_PATH}/zsh/.zshrc ~/.zshrc
ln -sf ${THIS_PATH}/zsh/.zshrc.pre-oh-my-zsh ~/.zshrc.pre-oh-my-zsh

ln -sf ${THIS_PATH}/vim/.vimrc ~/.vimrc
# ln -sf ${THIS_PATH}/nvim/init.vim ~/.config/nvim/init.vim

ln -sf ${THIS_PATH}/vcs/.gitconfig ~/.gitconfig
ln -sf ${THIS_PATH}/vcs/.gitignore_global ~/.gitignore_global
ln -sf ${THIS_PATH}/vcs/.hgignore_global ~/.hgignore_global
ln -sf ${THIS_PATH}/vcs/.hgrc ~/.hgrc

echo "Done!"

source ~/.zshrc
