echo "Going to install vim stuff"
sudo apt-get install -y vim

echo "Installing Silver Searcher (ag)..."
sudo apt-get install -y silversearcher-ag

echo "Installing fuzzyfinder (fzf)..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim-startify
mkdir -p ~/.vim/files/info
