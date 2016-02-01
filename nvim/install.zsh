#!/usr/bin/env zsh
echo "Going to install NeoVim"

echo "Adding repo..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
echo "Updating..."
sudo apt-get -qq update
echo "Installing NeoVim..."
sudo apt-get install -y neovim

echo "Installing Python modules needed for NeoVim..."

sudo apt-get install -y python-dev python-pip python3-dev python3-pip
sudo pip2 install neovim
sudo pip3 install neovim
