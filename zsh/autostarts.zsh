# FASD
[ -s "/usr/bin/fasd" ] && eval "$(fasd --init auto)"

# kiex - Elixir version manager
[ -s "$HOME/.kiex/scripts/kiex" ] && . "$HOME/.kiex/scripts/kiex"

# nvm: Node Version Manager
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Virtualenvwrapper
[ -s /usr/local/bin/virtualenvwrapper.sh ] && . /usr/local/bin/virtualenvwrapper.sh
