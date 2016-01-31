# Default alias 'ag' is bound to 'sudo apt-get'..
if [ -f /usr/bin/ag ]; then
  # Use silversurfer-ag instead
  alias ag="/usr/bin/ag"
fi

# ZSH
alias "$"=""
alias dotfiles="$EDITOR $DOTFILES"
alias ae="$EDITOR $DOTFILES/zsh/aliases.zsh"
alias ar="source $DOTFILES/zsh/aliases.zsh"
alias ze="$EDITOR $DOTFILES/zsh/.zshrc"
alias zr="source $DOTFILES/zsh/.zshrc"

function mkcd
{
  command mkdir $1 && cd $1
}
alias mkcd=mkcd

# Mercurial
alias hgss='hg status -S'
