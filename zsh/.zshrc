source $DOTFILES/zsh/exports.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="bullet-train"
ZSH_THEME="rw"

source $DOTFILES/zsh/autostarts.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mercurial npm vagrant nvm node ubuntu fasd)

source $ZSH/oh-my-zsh.sh

source $DOTFILES/zsh/aliases.zsh
source $DOTFILES/zsh/zmv.zsh
source $DOTFILES/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
