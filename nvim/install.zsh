#!/usr/bin/env zsh
echo "Installing NeoVim..."

sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim

echo "Installing Python modules needed for NeoVim..."

sudo apt-get install -y python-dev python-pip python3-dev python3-pip
sudo pip2 install neovim
sudo pip3 install neovim
