# ZSH
alias ae="$EDITOR $DOTFILES/zsh/aliases.zsh"
alias ar="source $DOTFILES/zsh/aliases.zsh"
alias ze="$EDITOR $DOTFILES/zsh/.zshrc"
alias zr="source $DOTFILES/zsh/.zshrc"

function mkcd
{
  command mkdir $1 && cd $1
}
alias mkcd=mkcd
