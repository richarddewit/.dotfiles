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

cd "${0%/*}"

git submodule init
git submodule update

chmod +x ./vim/install.zsh
chmod +x ./nvim/install.zsh
chmod +x ./make_links.zsh

./vim/install.zsh &&
./nvim/install.zsh &&
./make_links.zsh

git clone https://github.com/richarddewit/rw.zsh-theme.git $ZSH_CUSTOM/themes/rw.zsh-theme
sudo wget https://raw.githubusercontent.com/clvv/fasd/master/fasd -O /usr/bin/fasd
sudo chmod +x /usr/bin/fasd

echo "Done!"

source ~/.zshrc
