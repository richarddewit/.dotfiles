#!/usr/bin/env bash
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

cd "${0%/*}"

echo "Installing ZSH and Oh-My-ZSH..."
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Making ZSH the default shell"
chsh -s $(which zsh)
zsh

chmod +x ./make_links.zsh
chmod +x ./nvim/install.zsh

./nvim/install.zsh
./make_links.zsh

echo "Done!"

source ~/.zshrc
