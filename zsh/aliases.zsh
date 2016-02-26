function run_bg
{
  nohup "$@" &>/dev/null & disown %%
}

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
alias sr="exec $SHELL"

alias ll='ls -alh --color=auto'
alias ls='ls -lh --color=auto'

function mkcd
{
  command mkdir -p $1 && cd $1
}
alias mkcd=mkcd

# FASD
alias a='fasd -a' # any
alias s='fasd -si' # show / search / select
alias d='fasd -d' # directory
alias f='fasd -f' # file
alias z='fasd_cd -d' # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # interactive directory jump

# Mercurial
alias hgss='hg status -S'

# React Native
alias rns='react-native start'
alias rna='react-native run-android'

# NPM
alias npmg='npm i -g'
alias npms='npm i -S'
alias npmd='npm i -D'

# Vagrant
alias vsus='vagrant suspend'
alias vssh='vagrant ssh'
alias vup='vagrant up'

# TortoiseHG
alias thg='run_bg thg'

# Emacs
alias gmacs='run_bg emacs $@'
