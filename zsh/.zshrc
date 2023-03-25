export PATH="$PATH:$HOME/.local/bin/scripts/"
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/zm/.local/bin
export PATH="/home/zemmsoares/.local/bin:$PATH"

ZSH_THEME="eastwood"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#custom aliases
alias vim='nvim'

alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'

