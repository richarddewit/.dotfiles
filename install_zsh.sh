echo "Installing ZSH and Oh-My-ZSH..."
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Making ZSH the default shell"
chsh -s $(which zsh)

echo "Done, continue with 'install_dotfiles.zsh'"
