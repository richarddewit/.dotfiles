# FASD
[ -s $(which fasd) ] && eval "$(fasd --init auto)"

# kiex - Elixir version manager
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# Node Version Manager: NVM
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
